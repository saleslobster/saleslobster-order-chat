// SalesLobster Order Chat - Demo Data Seed
List<Order__c> orders = new List<Order__c>();

orders.add(new Order__c(
    Customer_Email__c = 'john@example.com',
    Order_Date__c = Date.today().addDays(-3)
));

orders.add(new Order__c(
    Customer_Email__c = 'sarah@example.com',
    Order_Date__c = Date.today().addDays(-1)
));

orders.add(new Order__c(
    Customer_Email__c = 'mike@example.com',
    Order_Date__c = Date.today().addDays(-7)
));

orders.add(new Order__c(
    Customer_Email__c = 'emma@example.com',
    Order_Date__c = Date.today().addDays(-2)
));

orders.add(new Order__c(
    Customer_Email__c = 'demo@saleslobster.com',
    Order_Date__c = Date.today().addDays(-2)
));

insert orders;
System.debug('✅ Created ' + orders.size() + ' demo orders');
for (Order__c o : orders) {
    System.debug('Order: ' + o.Name + ' - ' + o.Customer_Email__c);
}
