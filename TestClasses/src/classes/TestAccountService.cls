@isTest
private class TestAccountService {
    static Id accountId;
    static String contactIds = '';
    Static Id contactId;
    @testSetup
    static void setupData(){
        Account acc = new Account(Name = 'new acc');
        insert acc;
        accountId = acc.Id;
        
        List<Contact> contacts = new List<Contact>();
        for(Integer loopNumber = 0; loopNumber < 3; loopNumber++){
            Contact c = new Contact(LastName = 'Last'+loopNumber, AccountId = accountId);
            contacts.add(c);
        }
        insert contacts;
        for(Contact con: contacts){
            contactIds += con.Id + ',';
            contactId = con.Id;
        }
    }   
    static void createNewContact(){
        Contact cont = new Contact(LastName = 'Last4', AccountId = accountId);
        insert cont;
        contactIds += cont.Id+',';
        contactId = cont.Id;
    }
    @isTest
    static void testAccountData(){
        Test.startTest();
        setupData();
        AccountService.updateAccountContacts(contactId);
        Account acc = [SELECT Id, ContactIds__c FROM Account WHERE Id = :accountId];
        system.assertEquals(contactIds.trim(),  acc.ContactIDs__c.trim());
        
        createNewContact();
        AccountService.updateAccountContacts(contactId);
        acc = [SELECT Id, ContactIds__c FROM Account WHERE Id = :accountId];
        system.assertEquals(contactIds.trim(),  acc.ContactIDs__c.trim());
        
        Test.stopTest();
    }
    
    
}