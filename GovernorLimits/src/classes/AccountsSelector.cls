public class AccountsSelector extends fflib_SObjectSelector {
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Account.Id,
            Account.Name,
            Account.Parent_Account__c,
            Account.ChildCount__c
        };
    }
    public Schema.SObjectType getSObjectType(){
        return Account.SObjectType;
    }
    public List<Account> selectById(Set<ID> idSet){
        return (List<Account>) selectSObjectsById(idSet);
    }
    public Map<Id, Integer> selectChildAccountsCountByAccountId(Set<Id> accountIdSet){
        Map<Id, Integer> accountChildCountMap = new Map<Id, Integer>();
        String query = String.format(
            'SELECT {0}, (SELECT Id FROM ChildAccounts__r) from {1} ' + 
            'WHERE Id IN :accountIdSet ',
            new List<String>{ getFieldListString(), getSObjectName() } );
        
        List<Account> accountList = Database.query(query);
        
        for(Account account : accountList){
            accountChildCountMap.put(account.Id, account.ChildAccounts__r.size());
        }
        return accountChildCountMap;
    }
}