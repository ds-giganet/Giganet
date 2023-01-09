@isTest
public class LeadHelperTest {
    public static testMethod void convertLeadTest() {
        Lead lead1         = TestDataFactory.createLead('ABCD', 'Johnson', false);
        lead1.RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get(Constants.LEAD_RECORD_TYPE_1).getRecordTypeId();
        insert lead1;
        Lead lead2         = TestDataFactory.createLead('WXYZ', 'Benson', false);
        lead2.RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get(Constants.LEAD_RECORD_TYPE_2).getRecordTypeId();
        insert lead2;
        Account account      = TestDataFactory.createAccount('CDEF', false);
        account.RecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(Constants.ACCOUNT_RECORD_TYPE_2).getRecordTypeId();
        insert account;
        Contact contact      = TestDataFactory.createContact(account.Id, 'EFGH', false);
        contact.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get(Constants.CONTACT_RECORD_TYPE_2).getRecordTypeId();
        insert contact;
        Test.startTest();
        // Testing Lead convertion without related records
        LeadHelper.LeadConvertionFlowParameters input1 = new LeadHelper.LeadConvertionFlowParameters();
        input1.leadId                                  = lead1.Id;
        input1.createOpportunity                       = false;
        // Converting the Lead
        LeadHelper.convertLead(new List<LeadHelper.LeadConvertionFlowParameters> {input1});
        // Retrieving converted records
        lead1                    = [SELECT ConvertedAccountId, ConvertedContactId, ConvertedOpportunityId FROM Lead WHERE Id =: lead1.Id];
        Account convertedAccount = [SELECT RecordTypeId FROM Account WHERE Id =: lead1.ConvertedAccountId];
        Contact convertedContact = [SELECT RecordTypeId FROM Contact WHERE Id =: lead1.ConvertedContactId];
        // Asserting converted records match the input
        System.assertEquals(convertedAccount.RecordTypeId, Schema.SObjectType.Account.getRecordTypeInfosByDeveloperName().get(Constants.ACCOUNT_RECORD_TYPE_1).getRecordTypeId());
        System.assertEquals(convertedContact.RecordTypeId, Schema.SObjectType.Contact.getRecordTypeInfosByDeveloperName().get(Constants.CONTACT_RECORD_TYPE_1).getRecordTypeId());
        System.assertNotEquals(lead1.ConvertedAccountId, account.Id);
        System.assertNotEquals(lead1.ConvertedContactId, contact.Id);
        System.assertNotEquals(lead1.ConvertedOpportunityId, null);
        // Testing Lead convertion with related records
        LeadHelper.LeadConvertionFlowParameters input2 = new LeadHelper.LeadConvertionFlowParameters();
        input2.leadId                                  = lead2.Id;
        input2.accountId                               = account.Id;
        input2.contactId                               = contact.Id;
        input2.createOpportunity                       = true;
        // Converting the Lead
        LeadHelper.convertLead(new List<LeadHelper.LeadConvertionFlowParameters> {input2});
        // Retrieving converted records
        lead2 = [SELECT ConvertedAccountId, ConvertedContactId, ConvertedOpportunityId FROM Lead WHERE Id =: lead2.Id];
        // Asserting converted records match the input
        System.assertEquals(lead2.ConvertedAccountId, account.Id);
        System.assertEquals(lead2.ConvertedContactId, contact.Id);
        System.assertEquals(lead2.ConvertedOpportunityId, null);
        Test.stopTest();
}   }