@isTest
private class TestBillToContactController {
	@testSetup
    static void setup(){
        Date closeDate = Date.today().addDays(-7);
        Opportunity opportunity = new Opportunity(
            Name = 'Opportunity1',
            CloseDate = closeDate,
            StageName = 'Prospecting'
        );
        insert opportunity;
        Account acc = new Account(Name = 'Account1');
        insert acc;
    }
    @isTest
    static void testControllerForNoOpportunity(){
        PageReference pageRef = Page.BillToContactPage;
        Test.setCurrentPage(pageRef);
        
        BillToCOntactController controller = new BillToContactController();
        System.assert(controller.opportunity == null);
    }
    @isTest
    static void testListOfContactsAsNull(){
        Opportunity opportunity = [SELECT Id, BillToContact__c, Manager__c FROM Opportunity WHERE NAME LIKE 'Opportunity1%' LIMIT 1];
        opportunity.Manager__c = [SELECT Id FROM Account WHERE NAME LIKE 'Account1%' LIMIT 1].Id;
        PageReference pageRef = Page.BillToContactPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',opportunity.id);
        
        BillToCOntactController controller = new BillToContactController();
        controller.opportunity = opportunity;
        System.assert(controller.getListOfContacts() == null);
    }
    @isTest
    static void testListOfContacts(){
        Opportunity opportunity = [SELECT Id, BillToContact__c, Manager__c FROM Opportunity WHERE NAME LIKE 'Opportunity1%' LIMIT 1];
        opportunity.Manager__c = [SELECT Id FROM Account WHERE NAME LIKE 'Account1%' LIMIT 1].Id;
        List<Contact> listOfContacts = new List<Contact>();
        for(Integer count = 1; count < 5; count++){
            Contact contact = new Contact(LastName = 'Last'+count, AccountId = opportunity.Manager__c);
            listOfContacts.add(contact);
        }
        insert listOfContacts;
        PageReference pageRef = Page.BillToContactPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',opportunity.id);
        
        BillToCOntactController controller = new BillToContactController();
        controller.opportunity = opportunity;
        System.assert(controller.getListOfContacts() != null);
    }
    @isTest
    static void testSaveMethod(){
        Opportunity opportunity = [SELECT Id, BillToContact__c, Manager__c FROM Opportunity WHERE NAME LIKE 'Opportunity1%' LIMIT 1];
        opportunity.Manager__c = [SELECT Id FROM Account WHERE NAME LIKE 'Account1%' LIMIT 1].Id;
        List<Contact> listOfContacts = new List<Contact>();
        for(Integer count = 1; count < 5; count++){
            Contact contact = new Contact(LastName = 'Last'+count, AccountId = opportunity.Manager__c);
            listOfContacts.add(contact);
        }
        insert listOfContacts;
        PageReference pageRef = Page.BillToContactPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',opportunity.id);
        
        BillToCOntactController controller = new BillToContactController();
        controller.opportunity = opportunity;
        controller.contactId = listOfContacts[0].Id;
        controller.save();
        System.assert(controller.listOfOpportunitiesToUpdate != null);
    }
    @isTest
    static void testClearMethod(){
        Opportunity opportunity = [SELECT Id, BillToContact__c, Manager__c FROM Opportunity WHERE NAME LIKE 'Opportunity1%' LIMIT 1];
        opportunity.Manager__c = [SELECT Id FROM Account WHERE NAME LIKE 'Account1%' LIMIT 1].Id;
        List<Contact> listOfContacts = new List<Contact>();
        for(Integer count = 1; count < 5; count++){
            Contact contact = new Contact(LastName = 'Last'+count, AccountId = opportunity.Manager__c);
            listOfContacts.add(contact);
        }
        insert listOfContacts;
        PageReference pageRef = Page.BillToContactPage;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('Id',opportunity.id);
        
        BillToCOntactController controller = new BillToContactController();
        controller.opportunity = opportunity;
        controller.opportunity.BillToContact__c = listOfContacts[0].Id;
        System.assert(controller.opportunity.BillToContact__c != null);
        controller.clear();
        System.assert(controller.opportunity.BillToContact__c == null);
    }
    @isTest
    static void testCancelMethod(){
        PageReference pageRef = Page.BillToContactPage;
        Test.setCurrentPage(pageRef);
        
        BillToCOntactController controller = new BillToContactController();
        System.assertEquals('/006/o', controller.cancel().getUrl());
    }
}