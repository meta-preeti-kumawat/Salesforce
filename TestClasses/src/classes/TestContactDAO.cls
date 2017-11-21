@isTest
private class TestContactDAO {
    @isTest
    static void testAccountRelatedToContactId(){
        Account acc = new Account(Name = 'new acc');
        insert acc;
        Contact contact = new Contact(LastName = 'Last', AccountId = acc.Id);
        insert contact;
        System.assertEquals(acc.Id, ContactDAO.getAccountRelatedToContactId(contact.Id));
    }
}