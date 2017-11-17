public class ContactDAO {
    public static Id getAccountRelatedToContactId(Id contactId){
        Contact contact = [SELECT AccountId From Contact WHERE Contact.ID = :contactId];
        return contact.AccountId;
    }
}