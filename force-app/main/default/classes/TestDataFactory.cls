public class TestDataFactory {
    public static Account createAccount(String name, Boolean insertFlag) {
        Account account           = new Account();
        account.Name              = name;
        account.BillingStreet     = 'Test Street';
        account.BillingCity       = 'Test City';
        account.BillingState      = 'Test State';
        account.BillingPostalCode = 'Test Postcode';
        // Checking if record should be saved
        if(insertFlag) {
            insert account;
        }
        return account;
    }
    public static Account_Development_Plan__c createADP(Id accountId, Boolean insertFlag) {
        Account_Development_Plan__c adp    = new Account_Development_Plan__c();
        adp.Account__c                     = accountId;
        adp.Status__c                      = Constants.UTILITIES_STATUS_1;
        adp.ADP_Review_Frequency__c        = Constants.UTILITIES_DATE_FREQUENCY_1;
        adp.Days_to_Complete_ADP_Review__c = 1;
        adp.From__c                        = System.today();
        adp.Period__c                      = Constants.UTILITIES_DATE_PERIOD_4;
        // Checking if record should be saved
        if(insertFlag) {
            insert adp;
        }
        return adp;
    }
    public static Contact createContact(Id accountId, String lastName, Boolean insertFlag) {
        Contact contact           = new Contact();
        contact.AccountId         = accountId;
        contact.FirstName         = 'Test';
        contact.LastName          = lastName;
        contact.Email             = lastName + '@test.com';
        contact.MailingStreet     = 'Test Street';
        contact.MailingCity       = 'Test City';
        contact.MailingState      = 'Test State';
        contact.MailingPostalCode = 'Test Postcode';
        // Checking if record should be saved
        if(insertFlag) {
            insert contact;
        }
        return contact;
    }
    public static Lead createLead(String companyName, String lastName, Boolean insertFlag) {
        Lead lead       = new Lead();
        lead.Company    = companyName;
        lead.FirstName  = 'Test';
        lead.LastName   = lastName;
        lead.Email      = lastName + '@test.com';
        lead.Street     = 'Test Street';
        lead.City       = 'Test City';
        lead.State      = 'Test State';
        lead.PostalCode = 'Test Postcode';
        // Checking if record should be saved
        if(insertFlag) {
            insert lead;
        }
        return lead;
    }
    public static Opportunity createOpportunity(Id accountId, Boolean insertFlag) {
        Opportunity opportunity = new Opportunity();
        opportunity.AccountId   = accountId;
        // Checking if record should be saved
        if(insertFlag) {
            insert opportunity;
        }
        return opportunity;
    }
    public static Product__c createProduct(Product2 product2, Boolean insertFlag) {
        Product__c product         = new Product__c();
        product.Name               = product2.Name;
        product.Product__c         = product2.Id;
        product.Type__c            = product2.Type__c;
        product.Install_Amount__c  = 300;
        product.Install_GP__c      = 100;
        product.Monthly_GP__c      = 100;
        product.Monthly_Revenue__c = 100;
        product.Quantity__c        = 1;
        product.Term__c            = 12;
        // Checking if record should be saved
        if(insertFlag) {
            insert product;
        }
        return product;
    }
    public static Product2 createProduct2(String name, String family, String type, Boolean insertFlag) {
        Product2 product = new Product2();
        product.Name     = name;
        product.Family   = family;
        product.Type__c  = type;
        product.isActive = true;
        // Checking if record should be saved
        if(insertFlag) {
            insert product;
        }
        return product;
}   }