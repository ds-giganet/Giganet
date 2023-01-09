public class ADPTriggerHandler {
    public static void createADPReviewTasks(Map<Id, Account_Development_Plan__c> newADPs, Map<Id, Account_Development_Plan__c> oldADPs) {
        Set<Id> accountIds = new Set<Id>();
        Set<Id> adpIds     = new Set<Id>();
        // Builds adpIds set to retrive existing ADP Review Tasks
        for(Account_Development_Plan__c adp : newADPs.values()) {
            // New ADPs
            if(oldADPs == null && String.isNotEmpty(adp.Period__c) && String.isNotEmpty(adp.ADP_Review_Frequency__c) && adp.From__c != null) {
                accountIds.add(adp.Account__c);
                adpIds.add(adp.Id);
            }
            // Changed ADPs
            else if(oldADPs != null) {
                Account_Development_Plan__c oldADP = oldADPs.get(adp.Id);
                // Determine if any of the relevant fields were changed
                if((adp.Period__c != oldADP.Period__c || adp.ADP_Review_Frequency__c != oldADP.ADP_Review_Frequency__c || adp.From__c != oldADP.From__c) && String.isNotEmpty(adp.Period__c) && adp.From__c != null) {
                    accountIds.add(adp.Account__c);
                    adpIds.add(adp.Id);
        }   }   }
        if(adpIds.size() > 0) {
            Map<Id, Account> adpAccounts = new Map<Id, Account> ([SELECT Id, OwnerId, Name FROM Account WHERE Id IN : accountIds]);
            List<Task> newADPReviewTasks = new List<Task>();
            List<Task> oldADPReviewTasks = new List<Task>();
            // Building ADP Review Tasks list that will be deleted
            for(Task adpTask : [SELECT Id FROM Task WHERE WhatId IN : adpIds AND Status =: Constants.TASK_STATUS_1]) {
                oldADPReviewTasks.add(adpTask);
            }
            // Checks if there are old ADP Review Tasks before delete
            if(oldADPReviewTasks.size() > 0) {
                delete oldADPReviewTasks;
            }
            // Building ADP Review Tasks list that will be inserted
            for(Id adpId : adpIds) {
                Account_Development_Plan__c adp = newADPs.get(adpId);
                // Creating ADP Review Tasks for each period based on start date and frequency
                if(adp != null) {
                    newADPReviewTasks.addAll(ADPHelper.createADPReviewTasks(adpAccounts.get(adp.Account__c), adp));
            }   }
            // Checks if there are new ADP Review Tasks before insert
            if(newADPReviewTasks.size() > 0) {
                insert newADPReviewTasks;
}   }   }   }