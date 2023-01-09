trigger LocationTrigger on Location__c (before insert) {
    if(!Feature_Switch__c.getInstance().Disable_Location_Triggers__c) {
        if(Trigger.isBefore && Trigger.isInsert) {
            // LocationTriggerHandler
        }
    }
}