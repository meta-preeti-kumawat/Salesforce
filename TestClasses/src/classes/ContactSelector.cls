public class ContactSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Contact.Id,
            Contact.Name,
            Contact.AccountId
        };
    }
    public Schema.SObjectType getSObjectType(){
        return Contact.SObjectType;
    }
    public List<Contact> selectById(Set<ID> idSet){
        return (List<Contact>) selectSObjectsById(idSet);
    }
    public List<Contact> selectByAccountId(Set<ID> idSet){
        String query = String.format(
            'SELECT {0} FROM {1} '+
            'WHERE AccountId IN :idSet', 
            new List<String> {getFieldListString(), getSObjectName()});
        return (List<Contact>) Database.query(query);
    }
    public Map<Id,Id> selectAccountIdByContactId(Set<ID> idSet){
        String query = String.format(
            'SELECT {0} FROM {1} '+
            'WHERE Id IN :idSet', 
            new List<String> {getFieldListString(), getSObjectName()});
        List<Contact> listOfContacts = (List<Contact>) Database.query(query);
        Map<Id, Id> contactToAccountMapping = new Map<Id, Id>();
        for(Contact contact : listOfContacts){
            contactToAccountMapping.put(contact.Id, contact.AccountId);
        }
        return contactToAccountMapping;
    }
}