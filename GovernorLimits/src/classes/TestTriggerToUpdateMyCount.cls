@isTest
private class TestTriggerToUpdateMyCount {
    
    @testSetup
    static void setup(){
        List<Class__c> listOfClasses = new List<Class__c>();
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer numberOfClasses = 0; numberOfClasses < 3; numberOfClasses++){
            Class__c classInstance = new Class__c(Name = ''+(numberOfClasses+1), MaxSize__c = 10);
            listOfClasses.add(classInstance);
        }
        insert listOfClasses;
        
        for(Class__c classInstance : listOfClasses){
            for(Integer numberOfstudents = 0; numberOfstudents < 5; numberOfstudents++){
                Student__c student = new Student__c(Last_Name__c = 'st'+(numberOfstudents+1), Sex__c = 'Female', class__c = classInstance.Id);
                listOfStudents.add(student);
            }
        }
        insert listOfStudents;
    }
    @isTest
    static void testTriggerOnInsert(){
        Id classId = [SELECT Id FROM Class__c WHERE Name = '3' LIMIT 1].Id;
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer numberOfstudents = 0; numberOfstudents < 5; numberOfstudents++){
            Student__c student = new Student__c(Last_Name__c = 'st'+(numberOfstudents+1), Sex__c = 'Female', class__c = classId);
            listOfStudents.add(student);
        }
        Test.startTest();
        insert listOfStudents;
        Test.stopTest();
        System.assertEquals(10, [SELECT MyCount__c FROM Class__c WHERE ID = :classId].MyCount__c);
    }
    @isTest
    static void testTriggerOnDelete(){
        Class__c classInstance = [SELECT Id, (SELECT Id FROM Students__r) FROM Class__c WHERE Name = '3' LIMIT 1];
        List<Student__c> listOfStudents = classInstance.Students__r;
        
        Test.startTest();
        delete listOfStudents;
        Test.stopTest();
        System.assertEquals(0, [SELECT MyCount__c FROM Class__c WHERE ID = :classInstance.Id].MyCount__c);
    }
    @isTest
    static void testTriggerOnUpdate(){
        Class__c newClass = new CLass__c(Name = 'N1', MaxSize__c = 10);
        insert newClass;
        Class__c classInstance = [SELECT Id, (SELECT Id FROM Students__r) FROM Class__c WHERE Name = '3' LIMIT 1];
        List<Student__c> listOfStudents = classInstance.Students__r;
        
        for(Student__c student : listOfStudents){
            student.class__c = newClass.Id;
        }
        Test.startTest();
        update listOfStudents;
        Test.stopTest();
        System.assertEquals(0, [SELECT MyCount__c FROM Class__c WHERE ID = :classInstance.Id].MyCount__c);
        System.assertEquals(listOfStudents.size(), [SELECT MyCount__c FROM Class__c WHERE ID = :newClass.Id].MyCount__c);
    }
    @isTest
    static void testTriggerOnUndelete(){
        Class__c classInstance = [SELECT Id, (SELECT Id FROM Students__r) FROM Class__c WHERE Name = '3' LIMIT 1];
        List<Student__c> listOfStudents = classInstance.Students__r;
        delete listOfStudents;
        
        Test.startTest();
        undelete listOfStudents;
        Test.stopTest();
        System.assertEquals(listOfStudents.size(), [SELECT MyCount__c FROM Class__c WHERE ID = :classInstance.Id].MyCount__c);
    }
    @isTest
    static void testTriggerOnUpsert(){
        Class__c newClass = new CLass__c(Name = 'N1', MaxSize__c = 10);
        insert newClass;
        Class__c classInstance = [SELECT Id, (SELECT Id FROM Students__r) FROM Class__c WHERE Name = '3' LIMIT 1];
        List<Student__c> listOfStudents = classInstance.Students__r;
        
        for(Student__c student : listOfStudents){
            student.class__c = newClass.Id;
        }
        for(Integer numberOfstudents = 0; numberOfstudents < 3; numberOfstudents++){
            Student__c student = new Student__c(Last_Name__c = 'st'+(numberOfstudents+1), Sex__c = 'Female', class__c = classInstance.Id);
            listOfStudents.add(student);
        }
        Test.startTest();
        upsert listOfStudents;
        Test.stopTest();
        System.assertEquals(3, [SELECT MyCount__c FROM Class__c WHERE ID = :classInstance.Id].MyCount__c);
        System.assertEquals(5, [SELECT MyCount__c FROM Class__c WHERE ID = :newClass.Id].MyCount__c);
    }
}