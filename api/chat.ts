import OpenAI from 'openai';
import { ChatRequest, ChatResponse, ChatMessage } from '../lib/types';
import { findOrderByNumber } from '../lib/salesforce';
import { SYSTEM_PROMPT, buildOrderContext, extractOrderNumber } from '../lib/prompts';

const openai = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

export const config = {
  runtime: 'edge',
};

export default async function handler(req: Request): Promise<Response> {
  if (req.method !== 'POST') {
    return new Response('Method not allowed', { status: 405 });
  }

  try {
    const body: ChatRequest = await req.json();
    const { message, conversationHistory, orderContext } = body;

    // Try to extract order number from message
    const orderNumber = extractOrderNumber(message);
    let currentOrder = orderContext;

    // If we found an order number and don't have context (or it's a different order)
    if (orderNumber && (!currentOrder || !currentOrder.Name.includes(orderNumber))) {
      try {
        currentOrder = await findOrderByNumber(orderNumber);
      } catch (e) {
        console.error('Error looking up order:', e);
      }
    }

    // Build messages for OpenAI
    const messages: OpenAI.Chat.ChatCompletionMessageParam[] = conversationHistory.map((msg) => ({
      role: msg.role,
      content: msg.content,
    }));

    // Add current user message
    messages.push({
      role: 'user',
      content: message,
    });

    // Build system prompt with order context if available
    let systemPrompt = SYSTEM_PROMPT;
    if (currentOrder) {
      systemPrompt += '\n' + buildOrderContext(currentOrder);
    }

    // Call OpenAI GPT-4o-mini (fast and affordable)
    const response = await openai.chat.completions.create({
      model: 'gpt-4o-mini',
      max_tokens: 500,
      system: systemPrompt,
      messages: messages,
    });

    const reply =
      response.choices[0].message.content || 'I encountered an error. Please try again.';

    const chatResponse: ChatResponse = {
      reply,
      orderContext: currentOrder,
    };

    return new Response(JSON.stringify(chatResponse), {
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (error) {
    console.error('Chat error:', error);
    return new Response(
      JSON.stringify({
        reply: 'Sorry, I encountered an error. Please try again or contact support@example.com.',
        orderContext: null,
      }),
      { status: 500, headers: { 'Content-Type': 'application/json' } }
    );
  }
}
