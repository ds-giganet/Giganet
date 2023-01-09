trigger ADPTrigger on Account_Development_Plan__c (after insert, after update) {
    if(!Feature_Switch__c.getInstance().Disable_ADP_Triggers__c) {
        if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
            ADPTriggerHandler.createADPReviewTasks(Trigger.newMap, Trigger.oldMap);
}   }   }