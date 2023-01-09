public class InteractionHelper {
    public static Account createAccountFromInteraction(Interaction__c interaction) {
        Account account = new Account();
        
        return account;
    }
    public static Lead createLeadFromInteraction(Interaction__c interaction) {
        Lead lead       = new Lead();/* Test commit
        lead.Company    = interaction.Company__c;
        lead.Email      = interaction.Email__c;
        lead.FirstName  = interaction.First_Name__c;
        lead.LastName   = interaction.Last_Name__c;
        lead.Street     = interaction.Street__c;
        lead.Postalcode = interaction.Postcode__c;
        lead.City       = interaction.City__c;
        if(interaction.Location_Type__c == Constants.INTERACTION_LOCATION_TYPE_1) {
            lead.RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get(Constants.LEAD_RECORD_TYPE_1).getRecordTypeId();
        }
        else {
            lead.RecordTypeId = Schema.SObjectType.Lead.getRecordTypeInfosByDeveloperName().get(Constants.LEAD_RECORD_TYPE_3).getRecordTypeId();
        }*/
        return lead;
    }
    public static Location__c createLocationFromInteraction(Interaction__c interaction) {
        Location__c location  = new Location__c();/*
        location.Name         = interaction.UPRN__c;
        location.UPRN__c      = interaction.UPRN__c;
        location.Type__c      = interaction.Location_Type__c;
        location.Street__c    = interaction.Street__c;
        location.Postcode__c  = interaction.Postcode__c;
        location.City__c      = interaction.City__c;
        location.RecordTypeId = Schema.SObjectType.Location__c.getRecordTypeInfosByName().get(Constants.LOCATION_RECORD_TYPE_2).getRecordTypeId();
        */
        return location;
}   }