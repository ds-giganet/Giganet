public with sharing class OpportunityHelper {
    public static Map<Id, Opportunity> getOpportunities(Set<Id> opportunityIds) {
        return new Map<Id, Opportunity>([
            SELECT Id, Name
            FROM Opportunity WHERE Id IN : opportunityIds
        ]); 
    }
    public static Map<Id, Opportunity> getOpportunitiesWithProducts(Set<Id> opportunityIds) {
        return new Map<Id, Opportunity>([
            SELECT Id, Name,
            (
                SELECT Id, Name, Parent__c, Product__c, Product__r.Name, Product__r.Icon__c, Supplier__c, Supplier__r.Name, Install_Amount__c, Install_GP__c, Monthly_GP__c, Monthly_Revenue__c, Quantity__c, Term__c, Location__c, Location__r.Name
                FROM Opportunity_Products__r
            )
            FROM Opportunity WHERE Id IN : opportunityIds
        ]); 
}   }