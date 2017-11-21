@isTest
private class TestStudentExtension {
	@testSetup
    static void setup(){
        Class__c classInstance = new Class__c(Name = 'TestClass', MaxSize__c = 10);
        insert classInstance;
        Student__c student = new Student__c(Last_Name__c = 'LastStudent', Sex__c = 'Male', Class__c = classInstance.Id);
        insert student;
    }
    @isTest
    static void testPDFAttachment(){
        Student__c student = [SELECT Id, Name FROM Student__c WHERE Last_Name__c LIKE 'LastStudent%' LIMIT 1];
    	ApexPages.StandardController stdController = new ApexPages.StandardController(student);
        StudentExtension extension = new StudentExtension(stdController);
        Blob content = Blob.valueOf('UNIT.TEST');
        extension.attachPDF();
        System.assert([SELECT Id FROM Attachment WHERE parentId = :student.Id].size() != 0);
    }
    @isTest
    static void testDeletionOfPDFAttachment(){
        Student__c student = [SELECT Id, Name FROM Student__c WHERE Last_Name__c LIKE 'LastStudent%' LIMIT 1];
    	ApexPages.StandardController stdController = new ApexPages.StandardController(student);
        StudentExtension extension = new StudentExtension(stdController);
        Blob content = Blob.valueOf('UNIT.TEST');
        extension.attachPDF();
        Attachment attach = [SELECT Id, Name FROM Attachment WHERE parentId = :student.Id LIMIT 1];
        System.assert(attach != null);
        extension.deletePreviousAttachment(attach.Name);
        System.assert([SELECT Id, Name FROM Attachment WHERE parentId = :student.Id].size() == 0);
    }
}