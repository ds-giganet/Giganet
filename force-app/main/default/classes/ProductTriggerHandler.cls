public with sharing class ProductTriggerHandler {
    public static void calculateOpportunityFinancialFields(List<Product__c> newRecords, Map<Id, Product__c> oldMap) {
        // Recreate functionality from Giganet Products flow
        // Maybe we can use DLRS app?
    }
    public static void deleteGiganetProducts(Map<Id, Product__c> oldMap) {
        Boolean functionSwitch = Utilities.functionSwitch.get('ProductTriggerHandler.deleteGiganetProducts');
        // Determining if function should run or not
        if(functionSwitch == null || functionSwitch) {
            Set<Id> giganetProductIds = new Set<Id>();
            // 
            for(Product__c oldRecord : oldMap.values()) {
                if(String.isNotEmpty(oldRecord.Giganet_Product__c)) {
                    giganetProductIds.add(oldRecord.Giganet_Product__c);
            }   }
            // Deleting all related Giganet Products
            if(giganetProductIds.size() > 0) {
                Utilities.functionSwitch.put('GiganetProductTriggerHandler.deleteOpportunityProducts', false);
                delete [SELECT Id FROM Giganet_Product__c WHERE Id IN : giganetProductIds];
    }   }   }
    public static void linkProduct2(List<Product__c> newRecords, Map<Id, Product__c> oldMap) {
        Map<String, Product2> productsByName = new Map<String, Product2>();
        Set<String> productNames             = new Set<String>();
        // Builds productNames set to retrive existing records by Name
        for(Product__c newRecord : newRecords) {
            if(oldMap == null) {
                productNames.add(newRecord.Name);
            }
            else {
                Product__c oldRecord = oldMap.get(newRecord.Id);
                // 
                if(newRecord.Name != oldRecord.Name) {
                    productNames.add(newRecord.Name);
        }   }   }
        if(productNames.size() > 0) {
            productsByName = ProductHelper.getProductsByName(productNames);
            // 
            for(Product__c newRecord : newRecords) {
                Product2 product     = productsByName.get(newRecord.Name);
                newRecord.Product__c = product != null ? product.Id : null;
}   }   }   }