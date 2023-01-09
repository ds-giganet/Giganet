public class EmailParameters {         
    @AuraEnabled @InvocableVariable public String whatId;
    @AuraEnabled @InvocableVariable public String targetObjectId;
    @AuraEnabled @InvocableVariable public String templateId;
    @AuraEnabled @InvocableVariable public String orgWideEmailAddressId;
    @AuraEnabled @InvocableVariable public String replyEmailAddress;
    @AuraEnabled @InvocableVariable public String toAddress;
    @AuraEnabled @InvocableVariable public String ccAddress;
    @AuraEnabled @InvocableVariable public String bccAddress;
    @AuraEnabled @InvocableVariable public String subject;
    @AuraEnabled @InvocableVariable public Boolean createActivity;
}