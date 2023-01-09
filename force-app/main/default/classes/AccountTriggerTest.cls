@isTest
public class AccountTriggerTest {
    public static List<Channel_Forecast__c> channelForecasts;
    public static testMethod void createChannelForecastsTest() {
        Account account = TestDataFactory.createAccount('Test Account', false);
        // Test Channel Forecasts automation when creating and updating Account
        Test.startTest();
        // Test Channel Forecasts creation when creating Account
        account.Channel_Forecast_Start_Date__c = System.today();
        account.ForecastPeriod__c              = Constants.UTILITIES_DATE_PERIOD_2;
        insert account;
        // Asserting the Channel Forecasts were created
        channelForecasts = [SELECT Id FROM Channel_Forecast__c];
        System.assertEquals(channelForecasts.size(), 3);
        // Test Channel Forecasts creation when updating Account
        account.Channel_Forecast_Start_Date__c = System.today();
        account.ForecastPeriod__c              = Constants.UTILITIES_DATE_PERIOD_4;
        update account;
        // Asserting the Channel Forecasts were created
        channelForecasts = [SELECT Id FROM Channel_Forecast__c];
        System.assertEquals(channelForecasts.size(), 12);
        // Test Channel Forecasts deletion when updating Account
        account.Channel_Forecast_Start_Date__c = System.today();
        account.ForecastPeriod__c              = Constants.UTILITIES_DATE_PERIOD_3;
        update account;
        // Asserting the Channel Forecasts were deleted
        channelForecasts = [SELECT Id FROM Channel_Forecast__c];
        System.assertEquals(channelForecasts.size(), 6);
        Test.stopTest();
    }
    public static testMethod void createChannelForecastsBulkTest() {
        List<Account> accounts = new List<Account>();
        // Creating 200 Account records
        for(Integer i = 0; i < 200; i++) {
            Account account                        = TestDataFactory.createAccount('Test Account ' + String.valueOf(i), false);
            account.Channel_Forecast_Start_Date__c = System.today();
            account.ForecastPeriod__c              = Constants.UTILITIES_DATE_PERIOD_2;
            // Building Account list to insert
            accounts.add(account);
        }
        // Test Channel Forecasts creation when creating bulk Accounts
        Test.startTest();
        insert accounts;
        // Asserting the Channel Forecasts were created
        channelForecasts = [SELECT Id FROM Channel_Forecast__c];
        System.assertEquals(channelForecasts.size(), 600);
        Test.stopTest();
}   }