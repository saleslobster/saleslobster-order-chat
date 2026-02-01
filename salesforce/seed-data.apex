// SalesLobster Order Chat - Demo Data Seed Script
// Execute via Developer Console > Debug > Execute Anonymous

List<Order__c> orders = new List<Order__c>();

// Order 1: Shipped (FedEx)
orders.add(new Order__c(
    Customer_Email__c = 'john@example.com',
    Customer_Phone__c = '+1-555-0101',
    Status__c = 'Shipped',
    Shipping_Carrier__c = 'FedEx',
    Tracking_Number__c = 'FX789456123',
    Estimated_Delivery__c = Date.today().addDays(2),
    Shipping_Address__c = '123 Main St, Chicago, IL 60601',
    Order_Total__c = 149.99,
    Order_Date__c = Date.today().addDays(-3),
    Items__c = '1x Wireless Headphones, 1x Phone Case'
));

// Order 2: Processing
orders.add(new Order__c(
    Customer_Email__c = 'sarah@example.com',
    Customer_Phone__c = '+1-555-0102',
    Status__c = 'Processing',
    Shipping_Carrier__c = null,
    Tracking_Number__c = null,
    Estimated_Delivery__c = Date.today().addDays(5),
    Shipping_Address__c = '456 Oak Ave, Austin, TX 78701',
    Order_Total__c = 299.00,
    Order_Date__c = Date.today().addDays(-1),
    Items__c = '1x Smart Watch'
));

// Order 3: Delivered
orders.add(new Order__c(
    Customer_Email__c = 'mike@example.com',
    Customer_Phone__c = '+1-555-0103',
    Status__c = 'Delivered',
    Shipping_Carrier__c = 'UPS',
    Tracking_Number__c = 'UPS1Z999AA10123456784',
    Estimated_Delivery__c = Date.today().addDays(-1),
    Shipping_Address__c = '789 Pine Rd, Seattle, WA 98101',
    Order_Total__c = 59.99,
    Order_Date__c = Date.today().addDays(-7),
    Items__c = '2x USB-C Cable, 1x Wall Charger'
));

// Order 4: Cancelled
orders.add(new Order__c(
    Customer_Email__c = 'emma@example.com',
    Customer_Phone__c = '+1-555-0104',
    Status__c = 'Cancelled',
    Shipping_Carrier__c = null,
    Tracking_Number__c = null,
    Estimated_Delivery__c = null,
    Shipping_Address__c = '321 Elm St, Denver, CO 80201',
    Order_Total__c = 499.00,
    Order_Date__c = Date.today().addDays(-2),
    Items__c = '1x Laptop Stand (Cancelled by customer)'
));

// Order 5: Shipped (DHL)
orders.add(new Order__c(
    Customer_Email__c = 'demo@saleslobster.com',
    Customer_Phone__c = '+1-555-0100',
    Status__c = 'Shipped',
    Shipping_Carrier__c = 'DHL',
    Tracking_Number__c = 'DHL1234567890',
    Estimated_Delivery__c = Date.today().addDays(1),
    Shipping_Address__c = '100 Demo Lane, San Francisco, CA 94102',
    Order_Total__c = 199.99,
    Order_Date__c = Date.today().addDays(-2),
    Items__c = '1x Bluetooth Speaker, 1x Carrying Case'
));

insert orders;

System.debug('✅ Created ' + orders.size() + ' demo orders');
for (Order__c o : orders) {
    System.debug('Order: ' + o.Name + ' - ' + o.Status__c + ' (' + o.Customer_Email__c + ')');
}
