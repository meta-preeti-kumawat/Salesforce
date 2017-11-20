@isTest
private class TestLoansTrigger {
    @isTest
    static void testTriggerBeforeInsert(){
        List<Loan__c> listOfLoans = new List<Loan__c>();
        CityManager__c cityManager = new CityManager__c(Manager__c = UserInfo.getUserId(), City__c = 'Jaipur');
        insert cityManager;
        for(Integer loanCount = 0; loanCount < 5; loanCount++){
            Loan__c loan = new Loan__c(Name = 'L'+loanCount, City__c = 'Jaipur');
            listOfLoans.add(loan);
        }
        for(Loan__c loan : listOfLoans){
            System.assert(loan.Manager__c == null);
        }
        Test.startTest();
        insert listOfLoans;
        Test.stopTest();
        System.assertEquals(UserInfo.getUserId(), [SELECT Manager__c FROM Loan__c WHERE Name LIKE 'L%' LIMIT 1].Manager__c);
    }
}