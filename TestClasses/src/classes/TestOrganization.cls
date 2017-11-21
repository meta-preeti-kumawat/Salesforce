@isTest
private class TestOrganization {
    @isTest
    static void testNumberOfSObjectsInOrganization(){
        System.assert(OrganizationDAO.getAllSObjects().size()!=0);
    }
}