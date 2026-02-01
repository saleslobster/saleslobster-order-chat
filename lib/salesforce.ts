import jsforce from 'jsforce';
import { Order } from './types';

let connection: jsforce.Connection | null = null;

async function getConnection(): Promise<jsforce.Connection> {
  if (connection) return connection;

  connection = new jsforce.Connection({
    loginUrl: process.env.SF_LOGIN_URL || 'https://login.salesforce.com',
    instanceUrl: process.env.SF_INSTANCE_URL,
  });

  // Using username/password auth
  await connection.login(
    process.env.SF_USERNAME!,
    process.env.SF_PASSWORD! + process.env.SF_SECURITY_TOKEN!
  );

  return connection;
}

export async function findOrderByNumber(orderNumber: string): Promise<Order | null> {
  const conn = await getConnection();

  // Normalize order number (handle "12345" or "ORD-00012345")
  let searchTerm = orderNumber.toUpperCase().trim();
  if (!searchTerm.startsWith('ORD-')) {
    searchTerm = `ORD-${searchTerm.padStart(5, '0')}`;
  }

  const result = await conn.query<Order>(`
    SELECT Id, Name, Customer_Email__c, Customer_Phone__c, Status__c,
           Shipping_Carrier__c, Tracking_Number__c, Estimated_Delivery__c,
           Shipping_Address__c, Order_Total__c, Order_Date__c, Items__c
    FROM Order__c
    WHERE Name = '${searchTerm}'
    LIMIT 1
  `);

  return result.records.length > 0 ? result.records[0] : null;
}

export async function findOrderByEmail(email: string): Promise<Order[]> {
  const conn = await getConnection();

  const result = await conn.query<Order>(`
    SELECT Id, Name, Customer_Email__c, Status__c, Order_Date__c, Order_Total__c
    FROM Order__c
    WHERE Customer_Email__c = '${email.toLowerCase().trim()}'
    ORDER BY Order_Date__c DESC
    LIMIT 5
  `);

  return result.records;
}
