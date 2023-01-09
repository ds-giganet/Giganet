public class ADPHelper {
    public static List<Task> createADPReviewTasks(Account account, Account_Development_Plan__c adp) {
        List<Task> tasks                    = new List<Task>();
        Date startDate                      = adp.From__c > System.today() ? adp.From__c : System.today();
        Integer numberOfPeriodsBetweenDates = Utilities.numberOfPeriodsBetweenDates(startDate, adp.To__c, adp.ADP_Review_Frequency__c);
        // Creating ADP Review Tasks for each period based on start date and frequency
        for(Integer i = 0; i < numberOfPeriodsBetweenDates; i++) {
            Date currentDate;
            // Increment currentDate based on the frequency
            if(adp.ADP_Review_Frequency__c == Constants.UTILITIES_DATE_FREQUENCY_1) {
                currentDate = startDate.addMonths(1);
            }
            else if(adp.ADP_Review_Frequency__c == Constants.UTILITIES_DATE_FREQUENCY_2) {
                currentDate = startDate.addMonths(3);
            }
            else if(adp.ADP_Review_Frequency__c == Constants.UTILITIES_DATE_FREQUENCY_3) {
                currentDate = startDate.addYears(1);
            }
            startDate = currentDate;
            // Creating Task record
            Task task             = new Task();
            task.ActivityDate     = currentDate.toStartOfMonth().addDays(Integer.valueOf(adp.Days_to_Complete_ADP_Review__c));
            task.OwnerId          = account.OwnerId;
            task.ReminderDateTime = Datetime.newInstance(task.ActivityDate.year(), task.ActivityDate.month(), task.ActivityDate.day()).addHours(9);
            task.IsReminderSet    = true;
            task.RecordTypeId     = Schema.SObjectType.Task.getRecordTypeInfosByDeveloperName().get(Constants.Task_RECORD_TYPE_1).getRecordTypeId();
            task.Subject          = account.Name + ' ' + Constants.TASK_RECORD_TYPE_LABEL_1 + ' ' + Utilities.monthNameByNumber.get(currentDate.month()) + ' ' + String.valueOf(currentDate.year());
            task.WhatId           = adp.Id;
            // Building Task list to insert
            tasks.add(task);
        }
        return tasks;
}   }