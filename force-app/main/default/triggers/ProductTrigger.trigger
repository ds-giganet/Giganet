trigger ProductTrigger on Product__c (before delete, before insert, before update) {
    if(!Feature_Switch__c.getInstance().Disable_Product_Triggers__c) {
        if(Trigger.isBefore) {
            if(Trigger.isDelete) {
                ProductTriggerHandler.deleteGiganetProducts(Trigger.oldMap);
            }
            else if(Trigger.isInsert || Trigger.isUpdate) {
                ProductTriggerHandler.calculateOpportunityFinancialFields(Trigger.new, Trigger.oldMap);
                ProductTriggerHandler.linkProduct2(Trigger.new, Trigger.oldMap);
}   }   }   }