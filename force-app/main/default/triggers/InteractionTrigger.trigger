trigger InteractionTrigger on Interaction__c (before insert) {
    if(!Feature_Switch__c.getInstance().Disable_Interaction_Triggers__c) {
        if(Trigger.isBefore && Trigger.isInsert) {
            InteractionTriggerHandler.linkRecords(Trigger.new);
}   }   }