trigger AccountTrigger on Account (after insert, after update) {
    if(!Feature_Switch__c.getInstance().Disable_Account_Triggers__c) {
        if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
            AccountTriggerHandler.createChannelForecasts(Trigger.newMap, Trigger.oldMap);
}   }   }