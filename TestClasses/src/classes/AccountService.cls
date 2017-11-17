public class AccountService {
    public static void updateAccountContacts(Id contactId){
        Id accountId = ContactDAO.getAccountRelatedToContactId(contactId);
        Account account = AccountDAO.getContactsRelatedToAccount(accountId);
        if(account != null){
            if(account.ContactIDs__c == null){
                String contactIds = '';
                if(account.Contacts != null){                 
                    for(Contact contact : account.Contacts){
                        contactIds += contact.Id + ',';
                    }
                }
                account.ContactIDs__c = contactIds;
            }
            else{
                if(!account.ContactIDs__c.contains(contactId)){
                    account.ContactIDs__c += contactId + ',';
                }
            }
            update account;
        }
    }
}