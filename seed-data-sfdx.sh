#!/bin/bash
# Seed demo orders using SFDX data API

set -e

ORG="saleslobster-dev"

echo "🚀 Seeding demo orders to Salesforce..."

# Calculate dates
TODAY=$(date +%Y-%m-%d)
TOMORROW=$(date -d "+1 day" +%Y-%m-%d)
TWODAYSAGO=$(date -d "-2 days" +%Y-%m-%d)
THREEDAYSAGO=$(date -d "-3 days" +%Y-%m-%d)
FIVEDAYSAHEAD=$(date -d "+5 days" +%Y-%m-%d)
SEVENDAYSAGO=$(date -d "-7 days" +%Y-%m-%d)

# Order 1: Shipped
echo "📦 Creating Order 1 (Shipped)..."
sf data create record \
  --sobject Order__c \
  --values "Customer_Email__c=john@example.com Customer_Phone__c=+1-555-0101 Status__c=Shipped Shipping_Carrier__c=FedEx Tracking_Number__c=FX789456123 Estimated_Delivery__c=$TOMORROW Shipping_Address__c='123 Main St, Chicago, IL 60601' Order_Total__c=149.99 Order_Date__c=$THREEDAYSAGO Items__c='1x Wireless Headphones, 1x Phone Case'" \
  --target-org $ORG --json | grep -o '"id":"[^"]*' | cut -d'"' -f4

# Order 2: Processing
echo "📦 Creating Order 2 (Processing)..."
sf data create record \
  --sobject Order__c \
  --values "Customer_Email__c=sarah@example.com Customer_Phone__c=+1-555-0102 Status__c=Processing Estimated_Delivery__c=$FIVEDAYSAHEAD Shipping_Address__c='456 Oak Ave, Austin, TX 78701' Order_Total__c=299.00 Order_Date__c=$TODAY Items__c='1x Smart Watch'" \
  --target-org $ORG --json | grep -o '"id":"[^"]*' | cut -d'"' -f4

# Order 3: Delivered
echo "📦 Creating Order 3 (Delivered)..."
sf data create record \
  --sobject Order__c \
  --values "Customer_Email__c=mike@example.com Customer_Phone__c=+1-555-0103 Status__c=Delivered Shipping_Carrier__c=UPS Tracking_Number__c=UPS1Z999AA10123456784 Estimated_Delivery__c=$TWODAYSAGO Shipping_Address__c='789 Pine Rd, Seattle, WA 98101' Order_Total__c=59.99 Order_Date__c=$SEVENDAYSAGO Items__c='2x USB-C Cable, 1x Wall Charger'" \
  --target-org $ORG --json | grep -o '"id":"[^"]*' | cut -d'"' -f4

# Order 4: Cancelled
echo "📦 Creating Order 4 (Cancelled)..."
sf data create record \
  --sobject Order__c \
  --values "Customer_Email__c=emma@example.com Customer_Phone__c=+1-555-0104 Status__c=Cancelled Shipping_Address__c='321 Elm St, Denver, CO 80201' Order_Total__c=499.00 Order_Date__c=$TWODAYSAGO Items__c='1x Laptop Stand (Cancelled by customer)'" \
  --target-org $ORG --json | grep -o '"id":"[^"]*' | cut -d'"' -f4

# Order 5: Shipped with DHL
echo "📦 Creating Order 5 (Shipped with DHL)..."
sf data create record \
  --sobject Order__c \
  --values "Customer_Email__c=demo@saleslobster.com Customer_Phone__c=+1-555-0100 Status__c=Shipped Shipping_Carrier__c=DHL Tracking_Number__c=DHL1234567890 Estimated_Delivery__c=$TOMORROW Shipping_Address__c='100 Demo Lane, San Francisco, CA 94102' Order_Total__c=199.99 Order_Date__c=$TWODAYSAGO Items__c='1x Bluetooth Speaker, 1x Carrying Case'" \
  --target-org $ORG --json | grep -o '"id":"[^"]*' | cut -d'"' -f4

echo "✅ Demo orders created successfully!"
