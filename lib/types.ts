export interface Order {
  Id: string;
  Name: string; // Order number (ORD-00001)
  Customer_Email__c: string;
  Customer_Phone__c: string;
  Status__c: 'Draft' | 'Processing' | 'Shipped' | 'Delivered' | 'Cancelled';
  Shipping_Carrier__c: string | null;
  Tracking_Number__c: string | null;
  Estimated_Delivery__c: string | null;
  Shipping_Address__c: string;
  Order_Total__c: number;
  Order_Date__c: string;
  Items__c: string;
}

export interface ChatMessage {
  role: 'user' | 'assistant';
  content: string;
}

export interface ChatRequest {
  message: string;
  conversationHistory: ChatMessage[];
  orderContext?: Order | null;
}

export interface ChatResponse {
  reply: string;
  orderContext?: Order | null;
}
