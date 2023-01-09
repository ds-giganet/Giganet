trigger GiganetProductTrigger on Giganet_Product__c (after insert, before delete) {
    if(!Feature_Switch__c.getInstance().Disable_Giganet_Product_Triggers__c) {
        if(Trigger.isAfter && Trigger.isInsert) {
            GiganetProductTriggerHandler.createOpportunityProducts(Trigger.newMap);
        }
        else if(Trigger.isBefore && Trigger.isDelete) {
            GiganetProductTriggerHandler.deleteOpportunityProducts(Trigger.oldMap);
}   }   }