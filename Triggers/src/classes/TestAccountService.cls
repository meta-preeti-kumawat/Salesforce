@isTest
private class TestAccountService {
	static Id accountId;
    static String contactIds = '';
    Static Id contactId;
    
    static void setupData(){
        Account a = new Account(Name = 'new acc');
        insert a;
        accountId = a.Id;
        
        List<Contact> contacts = new List<Contact>();
        for(Integer loopNumber = 0; loopNumber < 3; loopNumber++){
        	Contact c = new Contact(LastName = 'Last'+loopNumber, AccountId = accountId);
        	contacts.add(c);
        }
        insert contacts;
        for(Contact con: contacts){
            contactIds += con.Id + ',';
            System.debug(con.Id);
            contactId = con.Id;
            System.debug(contactId);
        }
    }
    
    @isTest
    static void testAccountData(){
        Test.startTest();
        setupData();
        System.debug(contactId);
        AccountService.updateAccountContacts(contactId);
        Account acc = [SELECT Id, ContactIds__c FROM Account WHERE Id = :accountId];
        system.assertEquals(contactIds.trim(),  acc.ContactIDs__c.trim());
        
        createNewContact();
        AccountService.updateAccountContacts(contactId);
        acc = [SELECT Id, ContactIds__c FROM Account WHERE Id = :accountId];
        system.assertEquals(contactIds.trim(),  acc.ContactIDs__c.trim());
        
        Test.stopTest();
    }
    
    static void createNewContact(){
        Contact cont = new Contact(LastName = 'Last4', AccountId = accountId);
		insert cont;
        contactIds += cont.Id+',';
        contactId = cont.Id;
    }
    
}