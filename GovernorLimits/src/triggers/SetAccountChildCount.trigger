trigger SetAccountChildCount on Account (after insert, after delete, after update, after undelete) {
	Set<ID> accountIds = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUndelete){
        for(Account account : Trigger.NEW){
            if(account.Parent_Account__c != null){
                accountIds.add(account.Parent_Account__c);
            }
        }
    }
    else{
        if(Trigger.isUpdate){
            for(Account account : Trigger.NEW){
                Account oldAccount = Trigger.oldMap.get(account.Id);
                if(oldAccount.Parent_Account__c <> account.Parent_Account__c){
                    accountIds.add(account.Parent_Account__c);
                    accountIds.add(oldAccount.Parent_Account__c);
                }
            }
        }
        else{
            if(Trigger.isDelete){
                for(Account account : Trigger.OLD){
                    if(account.Parent_Account__c != null){
                        accountIds.add(account.Parent_Account__c);
                    }
                }
            }
        }
    }
    List<Account> listOfAccountsToUpdate = new List<Account>();
    AccountsSelector accountsSelector = new AccountsSelector();
    Map<Id, Integer> accountChildCountMap = accountsSelector.selectChildAccountsCountByAccountId(accountIds);
    for(Account account : accountsSelector.selectById(accountIds)){
        if(accountChildCountMap.containsKey(account.Id)){
            account.ChildCount__c = accountChildCountMap.get(account.Id);
            listOfAccountsToUpdate.add(account);
        }
    }
    if(listOfAccountsToUpdate.size() > 0){
        update listOfAccountsToUpdate;
    }
}