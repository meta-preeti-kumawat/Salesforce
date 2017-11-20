public class AccountDAO {
    public static Account getContactsRelatedToAccount(Id accountId){
        Account acc = [SELECT Id, ContactIds__c, (SELECT Id FROM Contacts) FROM Account WHERE ID = :accountId];
        return acc;
    }
}