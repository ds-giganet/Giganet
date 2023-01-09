public class AccountHelper {
    public static List<Channel_Forecast__c> createChannelForecasts(Account account, Date startDate) {
        List<Channel_Forecast__c> channelForecasts = new List<Channel_Forecast__c>();
        Integer numberOfPeriodsBetweenDates        = Utilities.numberOfPeriodsBetweenDates(startDate, account.Channel_Forecast_End_Date__c, CONSTANTS.UTILITIES_DATE_FREQUENCY_1);
        // Creating Channel Forecasts for each month between start date and end date
        for(Integer i = 0; i < numberOfPeriodsBetweenDates; i++) {
            Date currentDate;
            // Increment currentDate
            currentDate = startDate.addMonths(1);
            startDate   = currentDate;
            // Creating Channel Forecast record
            Channel_Forecast__c forecast = new Channel_Forecast__c();
            forecast.Account__c          = account.Id;
            forecast.Expected__c         = 0; // This can be populated based on an average saved at the Account level
            forecast.Minimum__c          = 0; // This can be populated based on an average saved at the Account level
            forecast.Upside__c           = 0; // This can be populated based on an average saved at the Account level
            forecast.Forecast_Date__c    = startDate;
            forecast.Month__c            = Utilities.monthNameByNumber.get(currentDate.month());
            forecast.Year__c             = String.valueOf(currentDate.year());
            // Building Channel Forecast list to insert
            channelForecasts.add(forecast);
        }
        return channelForecasts;
    }
    public static Map<Id, Account> getAccounts(Set<Id> accountIds) {
        return new Map<Id, Account>([
            SELECT Id, Name
            FROM Account WHERE Id IN : accountIds
        ]);
    }
    public static Map<String, Account> getSuppliersByName(Set<String> suppliersName) {
        Map<String, Account> suppliersByName = new Map<String, Account>();
        // Builds suppliersByName to be able to search Suppliers based on Name
        for(Account supplier : [SELECT Name FROM Account WHERE Name LIKE : suppliersName AND RecordTypeId =: Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(Constants.ACCOUNT_RECORD_TYPE_4).getRecordTypeId()]) {
            suppliersByName.put(supplier.Name, supplier);
        }
        return suppliersByName;
}   }