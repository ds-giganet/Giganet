/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
trigger dlrs_ProductTrigger on Product__c (before delete, before insert, before update, after delete, after insert, after undelete, after update) {
    if(!Feature_Switch__c.getInstance().Disable_Product_Triggers__c) {
        dlrs.RollupService.triggerHandler(Product__c.SObjectType);
}   }