@isTest
private class TestTriggerForFullClass {
    @isTest
    static void testDeletionForClassWithMoreThanOneFemaleStudents(){
        Class__c classInstance = new Class__c(Name = '1', MaxSize__c = 2);
        insert classInstance;
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer numberOfstudents = 0; numberOfstudents < 5; numberOfstudents++){
            Student__c student = new Student__c(Last_Name__c = 'st'+(numberOfstudents+1), Sex__c = 'Female', class__c = classInstance.Id);
            listOfStudents.add(student);
        }
        Test.startTest();
        Database.SaveResult[] result = Database.insert(listOfStudents, false);
        Test.stopTest();
        for(Database.SaveResult res : result){
            if(!res.isSuccess()){
                System.assertEquals('No space for new student',res.getErrors()[0].getMessage());
            }
        }
    }
}