#!/usr/bin/env node
const jsforce = require('jsforce');

// Get credentials from environment or SFDX
const username = process.env.SF_USERNAME || 'kudryk@resilient-narwhal-cf5l8q.com';
const password = process.env.SF_PASSWORD || '';
const securityToken = process.env.SF_SECURITY_TOKEN || '';

const conn = new jsforce.Connection({
  loginUrl: 'https://login.salesforce.com'
});

// Demo orders to seed
const orders = [
  {
    Customer_Email__c: 'john@example.com',
    Customer_Phone__c: '+1-555-0101',
    Status__c: 'Shipped',
    Shipping_Carrier__c: 'FedEx',
    Tracking_Number__c: 'FX789456123',
    Estimated_Delivery__c: new Date(Date.now() + 2 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    Shipping_Address__c: '123 Main St, Chicago, IL 60601',
    Order_Total__c: 149.99,
    Order_Date__c: new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    Items__c: '1x Wireless Headphones, 1x Phone Case'
  },
  {
    Customer_Email__c: 'sarah@example.com',
    Customer_Phone__c: '+1-555-0102',
    Status__c: 'Processing',
    Shipping_Carrier__c: null,
    Tracking_Number__c: null,
    Estimated_Delivery__c: new Date(Date.now() + 5 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    Shipping_Address__c: '456 Oak Ave, Austin, TX 78701',
    Order_Total__c: 299.00,
    Order_Date__c: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    Items__c: '1x Smart Watch'
  },
  {
    Customer_Email__c: 'mike@example.com',
    Customer_Phone__c: '+1-555-0103',
    Status__c: 'Delivered',
    Shipping_Carrier__c: 'UPS',
    Tracking_Number__c: 'UPS1Z999AA10123456784',
    Estimated_Delivery__c: new Date(Date.now() - 1 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    Shipping_Address__c: '789 Pine Rd, Seattle, WA 98101',
    Order_Total__c: 59.99,
    Order_Date__c: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    Items__c: '2x USB-C Cable, 1x Wall Charger'
  },
  {
    Customer_Email__c: 'emma@example.com',
    Customer_Phone__c: '+1-555-0104',
    Status__c: 'Cancelled',
    Shipping_Carrier__c: null,
    Tracking_Number__c: null,
    Estimated_Delivery__c: null,
    Shipping_Address__c: '321 Elm St, Denver, CO 80201',
    Order_Total__c: 499.00,
    Order_Date__c: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    Items__c: '1x Laptop Stand (Cancelled by customer)'
  },
  {
    Customer_Email__c: 'demo@saleslobster.com',
    Customer_Phone__c: '+1-555-0100',
    Status__c: 'Shipped',
    Shipping_Carrier__c: 'DHL',
    Tracking_Number__c: 'DHL1234567890',
    Estimated_Delivery__c: new Date(Date.now() + 1 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    Shipping_Address__c: '100 Demo Lane, San Francisco, CA 94102',
    Order_Total__c: 199.99,
    Order_Date__c: new Date(Date.now() - 2 * 24 * 60 * 60 * 1000).toISOString().split('T')[0],
    Items__c: '1x Bluetooth Speaker, 1x Carrying Case'
  }
];

async function seedOrders() {
  try {
    console.log('🚀 Connecting to Salesforce...');
    await conn.login(username, password + securityToken);
    console.log('✅ Connected!');
    
    console.log(`📦 Creating ${orders.length} demo orders...`);
    const result = await conn.insert('Order__c', orders);
    
    console.log('\n✅ Demo orders created successfully!');
    console.log('\nCreated Orders:');
    result.forEach((res, idx) => {
      console.log(`  ${idx + 1}. ID: ${res.id} (Email: ${orders[idx].Customer_Email__c})`);
    });
    
    console.log('\n🎉 Seeding complete!');
    process.exit(0);
  } catch (error) {
    console.error('❌ Error seeding data:', error.message);
    process.exit(1);
  }
}

seedOrders();
