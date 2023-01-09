public with sharing class GiganetProductTriggerHandler {
    public static void createOpportunityProducts(Map<Id, Giganet_Product__c> newMap) {
        Map<String, Product2> productsByName     = new Map<String, Product2>();
        Map<String, Account> suppliersByName     = new Map<String, Account>();
        List<Product__c> newOpportunityProducts1 = new List<Product__c>();
        List<Product__c> newOpportunityProducts2 = new List<Product__c>();
        Set<String> productNames                 = new Set<String>();
        Set<String> supplierNames                = new Set<String>();
        // Builds productNames and supplierNames sets to retrive existing records by Name
        for(Giganet_Product__c newRecord : newMap.values()) {
            productNames.add(newRecord.Name);
            productNames.add(newRecord.Router__c);
            supplierNames.add(newRecord.Supplier__c);
        }
        productsByName  = ProductHelper.getProductsByName(productNames);
        suppliersByName = AccountHelper.getSuppliersByName(supplierNames);
        // 
        for(Giganet_Product__c newRecord : newMap.values()) {
            Product2 product = productsByName.get(newRecord.Name);
            Account supplier = suppliersByName.get(newRecord.Supplier__c);
            //
            Product__c opportunityProduct1         = new Product__c();
            opportunityProduct1.Name               = newRecord.Name;
            opportunityProduct1.Opportunity__c     = newRecord.Opportunity__c;
            opportunityProduct1.Giganet_Product__c = newRecord.Id;
            opportunityProduct1.Product__c         = product  != null ? product.Id  : null;
            opportunityProduct1.Supplier__c        = supplier != null ? supplier.Id : null;
            opportunityProduct1.Install_Amount__c  = newRecord.Install_Amount__c;
            opportunityProduct1.Install_GP__c      = newRecord.Install_Gross_Profit__c;
            opportunityProduct1.Monthly_GP__c      = newRecord.Monthly_Contract_GP__c;
            opportunityProduct1.Monthly_Revenue__c = newRecord.Monthly_Contract_Revenue__c;
            opportunityProduct1.Quantity__c        = newRecord.Number_of_Users__c;
            opportunityProduct1.Term__c            = newRecord.Term__c;
            //
            newOpportunityProducts1.add(opportunityProduct1);
        }
        insert newOpportunityProducts1;
        
        newOpportunityProducts1 = [SELECT Id, Name, Opportunity__c , Giganet_Product__c FROM Product__c WHERE Giganet_Product__c IN : newMap.keySet()];
        
        for(Product__c opportunityProduct : newOpportunityProducts1) {
            Product2 product = productsByName.get(newMap.get(opportunityProduct.Giganet_Product__c).Router__c);
            //
            if(product != null) {
                Product__c opportunityProduct2         = new Product__c();
                opportunityProduct2.Name               = product.Name;
                opportunityProduct2.Parent__c          = opportunityProduct.Id;
                opportunityProduct2.Opportunity__c     = opportunityProduct.Opportunity__c;
                opportunityProduct2.Giganet_Product__c = opportunityProduct.Giganet_Product__c;
                opportunityProduct2.Product__c         = product.Id;
                opportunityProduct2.Quantity__c        = 1;
                //
                newOpportunityProducts2.add(opportunityProduct2);
        }    }
        if(newOpportunityProducts2.size() > 0) {
            insert newOpportunityProducts2;
    }   }
    public static void deleteOpportunityProducts(Map<Id, Giganet_Product__c> oldMap) {
        Boolean functionSwitch = Utilities.functionSwitch.get('GiganetProductTriggerHandler.deleteOpportunityProducts');
        // Determining if function should run or not
        if(functionSwitch == null || functionSwitch) {
            List<Product__c> opportunityProducts = [SELECT Id FROM Product__c WHERE Giganet_Product__c IN : oldMap.keySet()];
            // Deleting all related Opportunity Products
            if(opportunityProducts.size() > 0) {
                Utilities.functionSwitch.put('ProductTriggerHandler.deleteGiganetProducts', false);
                delete opportunityProducts;
}   }   }   }