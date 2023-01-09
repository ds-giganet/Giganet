public class AccountTriggerHandler {
    public static void createChannelForecasts(Map<Id, Account> newAccounts, Map<Id, Account> oldAccounts) {
        Map<Id, List<Channel_Forecast__c>> forecastsByAccountId = new Map<Id, List<Channel_Forecast__c>>();
        // Builds accountIds set to retrive existing Channel Forecasts
        for(Account account : newAccounts.values()) {
            // New Accounts
            if(oldAccounts == null && account.Channel_Forecast_Start_Date__c != null && account.Channel_Forecast_End_Date__c != null) {
                forecastsByAccountId.put(account.Id, new List<Channel_Forecast__c>());
            }
            // Changed Accounts
            else if(oldAccounts != null) {
                Account oldAccount = oldAccounts.get(account.Id);
                // Determine if any of the relevant fields were changed
                if(account.Channel_Forecast_Start_Date__c != null && account.Channel_Forecast_End_Date__c != null && account.Channel_Forecast_End_Date__c != oldAccount.Channel_Forecast_End_Date__c) {
                    forecastsByAccountId.put(account.Id, new List<Channel_Forecast__c>());
        }   }   }
        if(forecastsByAccountId.size() > 0) {
            List<Channel_Forecast__c> newForecasts = new List<Channel_Forecast__c>();
            List<Channel_Forecast__c> oldForecasts = new List<Channel_Forecast__c>();
            // Builds forecastsByAccount to be able to search existing Channel Forecasts based on Account
            for(Channel_Forecast__c forecast : [SELECT Id, Account__c, Forecast_Date__c FROM Channel_Forecast__c WHERE Account__c IN : forecastsByAccountId.keySet() AND Forecast_Date__c > : System.today()]) {
                Account account = newAccounts.get(forecast.Account__c);
                // Checks if Channel Forecast should be deleted
                if(forecast.Forecast_Date__c > account.Channel_Forecast_End_Date__c) {
                    oldForecasts.add(forecast);
                }
                // Checks if forecastsByAccount already contains this Account
                else if(forecastsByAccountId.get(account.Id) == null) {
                    forecastsByAccountId.put(account.Id, new List<Channel_Forecast__c> {forecast});
                }
                else {
                    forecastsByAccountId.get(account.Id).add(forecast);
            }   }
            // Checks if there are new Channel Forecasts before insert
            if(oldForecasts.size() > 0) {
                delete oldForecasts;
            }
            for(Account account : [SELECT Id, Channel_Forecast_Start_Date__c, Channel_Forecast_End_Date__c FROM Account WHERE Id IN : forecastsByAccountId.keySet()]) {
                Date startDate = account.Channel_Forecast_Start_Date__c > System.today() ? account.Channel_Forecast_Start_Date__c : System.today();
                // Determining the start date for new forecasts
                for(Channel_Forecast__c forecast : forecastsByAccountId.get(account.Id)) {
                    if(forecast.Forecast_Date__c > startDate) {
                        startDate = forecast.Forecast_Date__c;
                    }
                }
                newForecasts.addAll(AccountHelper.createChannelForecasts(account, startDate));
            }
            // Checks if there are old Channel Forecasts before delete
            if(newForecasts.size() > 0 ) {
                insert newForecasts;
}   }   }   }