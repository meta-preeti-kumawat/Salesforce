@isTest
private class TestTriggerForFemaleStudentsInClass {
    private static List<Class__c> listOfClasses = new List<Class__c>();
    @isTest
    static void testDeletionForClassWithMoreThanOneFemaleStudents(){
        for(Integer numberOfClasses = 0; numberOfClasses < 5; numberOfClasses++){
            Class__c classInstance = new Class__c(Name = ''+(numberOfClasses+1), MaxSize__c = 10);
            listOfClasses.add(classInstance);
        }
        insert listOfClasses;
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Class__c classInstance : listOfClasses){
            for(Integer numberOfstudents = 0; numberOfstudents < 5; numberOfstudents++){
                Student__c student = new Student__c(Last_Name__c = 'st'+(numberOfstudents+1), Sex__c = 'Female', class__c = classInstance.Id);
                listOfStudents.add(student);
            }
            for(Integer numberOfstudents = 0; numberOfstudents < 5; numberOfstudents++){
                Student__c student = new Student__c(Last_Name__c = 'st'+(numberOfstudents+1), Sex__c = 'Male', class__c = classInstance.Id);
                listOfStudents.add(student);
            }
        }
        insert listOfStudents;
        Test.startTest();
        Database.DeleteResult[] result = Database.delete(listOfClasses, false);
        Test.stopTest();
        for(Database.DeleteResult res : result){
            System.assert(!res.isSuccess());
            System.assert(res.getErrors().size() > 0 );
            System.assertEquals('Cannot delete this class. More than one female students study here',res.getErrors()[0].getMessage());
        }
    }
    @isTest
    static void testDeletionForClassWithLessFemaleStudents(){
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Class__c classInstance : listOfClasses){
            for(Integer numberOfstudents = 0; numberOfstudents < 5; numberOfstudents++){
                Student__c student = new Student__c(Last_Name__c = 'st'+(numberOfstudents+1), Sex__c = 'Male', class__c = classInstance.Id);
                listOfStudents.add(student);
            }
        }
        insert listOfStudents;
        Test.startTest();
        Database.DeleteResult[] result = Database.delete(listOfClasses, false);
        Test.stopTest();
        for(Database.DeleteResult res : result){
            System.assert(res.isSuccess());
        }
    }
}