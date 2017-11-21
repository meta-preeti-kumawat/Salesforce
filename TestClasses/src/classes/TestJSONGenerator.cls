@isTest
private class TestJSONGenerator {
	@testSetup
    static void setup(){
        Class__c classInstance = new Class__c(Name = 'TestClass', MaxSize__c = 10);
        insert classInstance;
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer count = 0; count < 5; count++){
            Student__c student = new Student__c(Last_Name__c = 'Last'+count, Class__c = classInstance.Id, Sex__c = 'Male');
            listOfStudents.add(student);
        }
        insert listOfStudents;
    }
    @isTest
    static void testJSONData(){
        JSONGenerator generator = new JSONGenerator();
        System.assert(generator.jsonData != null);
    }
}