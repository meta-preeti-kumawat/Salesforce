@isTest
private class TestRelatedAccount {
	@testSetup
   	static void setup() {
        List<Opportunity> oppty = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            Opportunity o = new Opportunity(Name = 'Test ' + i,
                                            CloseDate = System.today() + 90,
                                            StageName = 'Prospecting');
            oppty.add(o);
        }
        insert oppty;
    }
   
    @isTest
    static void testNoOfRelatedAccounts() {
        Opportunity oppty = [SELECT Id, BillToContact__c, Manager__c FROM Opportunity WHERE 
                            Name = 'Test 0'];
        Account a = new Account(Name = 'Related Account');
        insert a;
        Contact c = new Contact(LastName = 'Related Contact', AccountId = a.Id);
        insert c;
        
        oppty.BillToContact__c = c.Id;
        update oppty;
        
        oppty = [SELECT Id, BillToContact__c, Manager__c FROM Opportunity WHERE 
                            Name = 'Test 0'];
        System.debug(oppty);
        System.assertNotEquals(null, oppty.Manager__c);
    } 
}