public class Utilities {
    public static Map<String, Boolean> functionSwitch    = new Map<String, Boolean> ();
    public static Map<Integer, String> monthNameByNumber = new Map<Integer, String> {
        1 => 'January', 2 => 'February', 3 => 'March', 4 => 'April', 5 => 'May', 6 => 'June',
        7 => 'July', 8 => 'August', 9 => 'September', 10 => 'October', 11 => 'November', 12 => 'December'
    };
    public static Integer numberOfPeriodsBetweenDates(Date startDate, Date endDate, String frequency) {
        Integer numberOfDaysBetweenDates    = startDate.daysBetween(endDate);
        Integer numberOfMonthsBetweenDates  = startDate.monthsBetween(endDate);
        Integer numberOfPeriodsBetweenDates = 0;
        if(frequency == Constants.UTILITIES_DATE_FREQUENCY_1)      { numberOfPeriodsBetweenDates = numberOfMonthsBetweenDates; }
        else if(frequency == Constants.UTILITIES_DATE_FREQUENCY_2) { numberOfPeriodsBetweenDates = Math.round(numberOfMonthsBetweenDates / 3); }
        else if(frequency == Constants.UTILITIES_DATE_FREQUENCY_3) { numberOfPeriodsBetweenDates = Math.round(numberOfMonthsBetweenDates / 12); }
        return numberOfPeriodsBetweenDates;
    }
    @InvocableMethod
    public static void sendEmail(List<List<EmailParameters>> parameters) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        for(List<EmailParameters> messageList : parameters) {
            for(EmailParameters message : messageList) {
                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                if(String.isNotEmpty(message.whatId))                { email.setWhatId(message.whatId); }
                if(String.isNotEmpty(message.targetObjectId))        { email.setTargetObjectId(message.targetObjectId); }
                if(String.isNotEmpty(message.templateId))            { email.setTemplateId(message.templateId); }
                if(String.isNotEmpty(message.orgWideEmailAddressId)) { email.setOrgWideEmailAddressId(message.orgWideEmailAddressId); }
                if(String.isNotEmpty(message.toAddress))             { email.setToAddresses(new List<String> { message.toAddress }); }
                if(String.isNotEmpty(message.replyEmailAddress))     { email.setReplyTo(message.replyEmailAddress); }
                if(String.isNotEmpty(message.ccAddress))             { email.setCCAddresses(new List<String> { message.ccAddress }); }
                if(String.isNotEmpty(message.bccAddress))            { email.setBCCAddresses(new List<String> { message.bccAddress }); }
                if(String.isNotEmpty(message.subject))               { email.setSubject(message.subject); }
                if(message.createActivity)                           { email.setSaveAsActivity(true); }
                emails.add(email);
        }   }
        if(emails.size() > 0) { Messaging.SendEmailResult[] results = Messaging.sendEmail(emails); }
}   }