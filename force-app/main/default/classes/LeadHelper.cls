public with sharing class LeadHelper {
    @InvocableMethod
    public static List<LeadConvertionFlowParameters> convertLead(List<LeadConvertionFlowParameters> parameters) {
        if(String.isNotEmpty(parameters[0].leadId)) {
            Database.LeadConvert leadConvert = new Database.LeadConvert();
            LeadStatus convertStatus         = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
            Lead lead                        = [SELECT RecordTypeId FROM Lead WHERE Id =: parameters[0].leadId];
            String leadRecordTypeName        = Schema.SObjectType.Lead.getRecordTypeInfosById().get(lead.RecordTypeId).getDeveloperName();
            // Setting conversion parametes
            leadConvert.setLeadId(parameters[0].leadId);
            leadConvert.setConvertedStatus(convertStatus.MasterLabel);
            leadConvert.setAccountId(parameters[0].accountId);
            leadConvert.setContactId(parameters[0].contactId);
            leadConvert.setDoNotCreateOpportunity(parameters[0].createOpportunity);
            // Converting the Lead
            Database.LeadConvertResult convertionResult = Database.convertLead(leadConvert);   
            // Retriving Account & Contact after conversion
            Account account = [SELECT RecordTypeId FROM Account WHERE Id =: convertionResult.getAccountId()];
            Contact contact = [SELECT RecordTypeId FROM Contact WHERE Id =: convertionResult.getContactId()];
            // Changing RecordType to match the one defined on Lead
            if(leadRecordTypeName == Constants.LEAD_RECORD_TYPE_1) {
                if(String.isEmpty(parameters[0].accountId)) {
                    account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(Constants.ACCOUNT_RECORD_TYPE_1).getRecordTypeId();
                    update account;
                }
                if(String.isEmpty(parameters[0].contactId)) {
                    contact.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get(Constants.CONTACT_RECORD_TYPE_1).getRecordTypeId();
                    update contact;
            }   }
            else if(leadRecordTypeName == Constants.LEAD_RECORD_TYPE_2) {
                if(String.isEmpty(parameters[0].accountId)) {
                    account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(Constants.ACCOUNT_RECORD_TYPE_2).getRecordTypeId();
                    update account;
                }
                if(String.isEmpty(parameters[0].contactId)) {
                    contact.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get(Constants.CONTACT_RECORD_TYPE_2).getRecordTypeId();
                    update contact;
            }   }
            parameters[0].accountId     = convertionResult.getAccountId();
            parameters[0].contactId     = convertionResult.getContactId();
            parameters[0].opportunityId = convertionResult.getOpportunityId();
        }
        return parameters;
    }
    public class LeadConvertionFlowParameters {         
        @InvocableVariable public String leadId;
        @InvocableVariable public String accountId;
        @InvocableVariable public String contactId;
        @InvocableVariable public String opportunityId;
        @InvocableVariable public Boolean createOpportunity;
}   }