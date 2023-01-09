@isTest
public class ADPTriggerTest {
    public static List<Task> adpReviewTasks;
    public static testMethod void createADPReviewTasksTest() {
        Account account                 = TestDataFactory.createAccount('Test Account', true);
        Account_Development_Plan__c adp = TestDataFactory.createADP(account.Id, false);
        // Test ADP Review Tasks automation when creating and updating Account Development Plan
        Test.startTest();
        // Test ADP Review Tasks creation when creating Account Development Plan
        adp.ADP_Review_Frequency__c = Constants.UTILITIES_DATE_FREQUENCY_1;
        adp.Period__c               = Constants.UTILITIES_DATE_PERIOD_1;
        insert adp;
        // Asserting the ADP Review Tasks were created
        adpReviewTasks = [SELECT Id FROM Task];
        System.assertEquals(adpReviewTasks.size(), 1);
        // Test ADP Review Tasks creation when updating Account Development Plan
        adp.ADP_Review_Frequency__c = Constants.UTILITIES_DATE_FREQUENCY_1;
        adp.Period__c               = Constants.UTILITIES_DATE_PERIOD_2;
        update adp;
        // Asserting the ADP Review Tasks were created
        adpReviewTasks = [SELECT Id FROM Task];
        System.assertEquals(adpReviewTasks.size(), 3);
        // Test ADP Review Tasks deletion when updating Account Development Plan
        adp.ADP_Review_Frequency__c = Constants.UTILITIES_DATE_FREQUENCY_2;
        adp.Period__c               = Constants.UTILITIES_DATE_PERIOD_2;
        update adp;
        // Asserting the ADP Review Tasks were created
        adpReviewTasks = [SELECT Id FROM Task];
        System.assertEquals(adpReviewTasks.size(), 1);
        // Test ADP Review Tasks creation when updating Account Development Plan
        adp.ADP_Review_Frequency__c = Constants.UTILITIES_DATE_FREQUENCY_2;
        adp.Period__c               = Constants.UTILITIES_DATE_PERIOD_3;
        update adp;
        // Asserting the ADP Review Tasks were created
        adpReviewTasks = [SELECT Id FROM Task];
        System.assertEquals(adpReviewTasks.size(), 2);
        // Test ADP Review Tasks creation when updating Account Development Plan
        adp.ADP_Review_Frequency__c = Constants.UTILITIES_DATE_FREQUENCY_1;
        adp.Period__c               = Constants.UTILITIES_DATE_PERIOD_4;
        update adp;
        // Asserting the ADP Review Tasks were created
        adpReviewTasks = [SELECT Id FROM Task];
        System.assertEquals(adpReviewTasks.size(), 12);
        Test.stopTest();
    }
    public static testMethod void createADPReviewTasksBulkTest() {
        List<Account_Development_Plan__c> adps = new List<Account_Development_Plan__c>();
        Account account                        = TestDataFactory.createAccount('Test Account', true);
        // Creating 200 Account Development Plan records
        for(Integer i = 0; i < 200; i++) {
            Account_Development_Plan__c adp    = TestDataFactory.createADP(account.Id, false);
            adp.ADP_Review_Frequency__c        = Constants.UTILITIES_DATE_FREQUENCY_3;
            adp.Days_to_Complete_ADP_Review__c = 1;
            adp.From__c                        = System.today();
            adp.Period__c                      = Constants.UTILITIES_DATE_PERIOD_4;
            // Building Account list to insert
            adps.add(adp);
        }
        // Test ADP Review Tasks creation when creating bulk Account Development Plans
        Test.startTest();
        insert adps;
        // Asserting the ADP Review Tasks were created
        adpReviewTasks = [SELECT Id FROM Task];
        System.assertEquals(adpReviewTasks.size(), 200);
        Test.stopTest();
}   }