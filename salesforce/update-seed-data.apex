// Update demo orders with complete data

List<Order__c> orders = [SELECT Id, Name, Customer_Email__c FROM Order__c ORDER BY Name LIMIT 5];

if (orders.size() == 5) {
    // Order 1: Shipped (FedEx)
    orders[0].Customer_Phone__c = '+1-555-0101';
    orders[0].Status__c = 'Shipped';
    orders[0].Shipping_Carrier__c = 'FedEx';
    orders[0].Tracking_Number__c = 'FX789456123';
    orders[0].Estimated_Delivery__c = Date.today().addDays(2);
    orders[0].Shipping_Address__c = '123 Main St, Chicago, IL 60601';
    orders[0].Order_Total__c = 149.99;
    orders[0].Items__c = '1x Wireless Headphones, 1x Phone Case';
    
    // Order 2: Processing
    orders[1].Customer_Phone__c = '+1-555-0102';
    orders[1].Status__c = 'Processing';
    orders[1].Shipping_Carrier__c = null;
    orders[1].Tracking_Number__c = null;
    orders[1].Estimated_Delivery__c = Date.today().addDays(5);
    orders[1].Shipping_Address__c = '456 Oak Ave, Austin, TX 78701';
    orders[1].Order_Total__c = 299.00;
    orders[1].Items__c = '1x Smart Watch';
    
    // Order 3: Delivered
    orders[2].Customer_Phone__c = '+1-555-0103';
    orders[2].Status__c = 'Delivered';
    orders[2].Shipping_Carrier__c = 'UPS';
    orders[2].Tracking_Number__c = 'UPS1Z999AA10123456784';
    orders[2].Estimated_Delivery__c = Date.today().addDays(-1);
    orders[2].Shipping_Address__c = '789 Pine Rd, Seattle, WA 98101';
    orders[2].Order_Total__c = 59.99;
    orders[2].Items__c = '2x USB-C Cable, 1x Wall Charger';
    
    // Order 4: Cancelled
    orders[3].Customer_Phone__c = '+1-555-0104';
    orders[3].Status__c = 'Cancelled';
    orders[3].Shipping_Carrier__c = null;
    orders[3].Tracking_Number__c = null;
    orders[3].Estimated_Delivery__c = null;
    orders[3].Shipping_Address__c = '321 Elm St, Denver, CO 80201';
    orders[3].Order_Total__c = 499.00;
    orders[3].Items__c = '1x Laptop Stand (Cancelled by customer)';
    
    // Order 5: Shipped (DHL)
    orders[4].Customer_Phone__c = '+1-555-0100';
    orders[4].Status__c = 'Shipped';
    orders[4].Shipping_Carrier__c = 'DHL';
    orders[4].Tracking_Number__c = 'DHL1234567890';
    orders[4].Estimated_Delivery__c = Date.today().addDays(1);
    orders[4].Shipping_Address__c = '100 Demo Lane, San Francisco, CA 94102';
    orders[4].Order_Total__c = 199.99;
    orders[4].Items__c = '1x Bluetooth Speaker, 1x Carrying Case';
    
    update orders;
    System.debug('✅ Updated ' + orders.size() + ' demo orders with complete data');
    for (Order__c o : orders) {
        System.debug(o.Name + ': ' + o.Status__c + ' (' + o.Customer_Email__c + ')');
    }
} else {
    System.debug('⚠️ Expected 5 orders, found: ' + orders.size());
}
