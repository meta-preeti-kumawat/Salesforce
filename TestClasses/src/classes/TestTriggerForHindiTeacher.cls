@isTest
private class TestTriggerForHindiTeacher {
    @isTest
    static void testUpdateWhenSubjectIsNotNull(){
        List<Contact> listOfTeachers = new List<Contact>();
        for(Integer numberOfTeachers = 0; numberOfTeachers < 5; numberOfTeachers++){
            Contact teacher = new Contact(LastName = 'teacher'+numberOfTeachers, Subjects__c = 'English');
            listOfTeachers.add(teacher);
        }
        insert listOfTeachers;
        for(Contact teacher : listOfTeachers){
            teacher.Subjects__c = 'Hindi';
        }
        Test.startTest();
        Database.SaveResult[] result = Database.update(listOfTeachers, false);
        Test.stopTest();
        for(Database.SaveResult res : result){
            System.assert(!res.isSuccess());
            System.assert(res.getErrors().size() > 0 );
            System.assertEquals('Subject Hindi cannot be added or removed',res.getErrors()[0].getMessage());
        }
    }
    @isTest
    static void testInsertWhenSubjectIsNotNull(){
        List<Contact> listOfTeachers = new List<Contact>();
        for(Integer numberOfTeachers = 0; numberOfTeachers < 5; numberOfTeachers++){
            Contact teacher = new Contact(LastName = 'teacher'+numberOfTeachers, Subjects__c = 'Hindi');
            listOfTeachers.add(teacher);
        }
        
        Test.startTest();
        Database.SaveResult[] result = Database.insert(listOfTeachers, false);
        Test.stopTest();
        for(Database.SaveResult res : result){
            System.assert(!res.isSuccess());
            System.assert(res.getErrors().size() > 0 );
            System.assertEquals('Hindi Teacher cannot be inserted',res.getErrors()[0].getMessage());
        }
    }
}