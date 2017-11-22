@isTest
private class TestAccountDAO {
    @isTest
    static void testAccountRelatedToContactId(){
        Account acc = new Account(Name = 'new acc');
        insert acc;
        List<Contact> contacts = new List<Contact>();
        for(Integer loopNumber = 0; loopNumber < 3; loopNumber++){
            Contact c = new Contact(LastName = 'Last'+loopNumber, AccountId = acc.Id);
            contacts.add(c);
        }
        insert contacts;
        System.assertEquals(3, AccountDAO.getContactsRelatedToAccount(acc.Id).Contacts.size());
    }
}