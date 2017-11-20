@isTest
private class TestClassController {
    @testSetup
    static void setup(){
        List<Class__c> listOfClasses = new List<Class__c>();
        For(Integer count = 0; count < 10; count++){        
            Class__c classInstance = new Class__c(Name = 'TestClass'+count, MaxSize__c = 10);
        	listOfClasses.add(classInstance);
        }
        insert listOfClasses;
    }
	@isTest
    static void testToSetClassObject(){
        Class__c classInstance = [SELECT Id FROM Class__c WHERE Name = 'TestClass1' LIMIT 1];
        PageReference pageRef = Page.ManageClass;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('classId',classInstance.id);
        ClassController controller = new ClassController();
        System.assert(!controller.isClassAvailable);
        controller.setClassObject();
        System.assert(controller.isClassAvailable);
    }
	@isTest
    static void testListOfClasses(){
        ClassController controller = new ClassController();
        System.assertEquals(10, controller.getClasses().size());
    }
	@isTest
    static void testToSaveClass(){
        Class__c classInstance = [SELECT Id FROM Class__c WHERE Name = 'TestClass1' LIMIT 1];
        PageReference pageRef = Page.ManageClass;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('classId',classInstance.id);
        ClassController controller = new ClassController();
        controller.setClassObject();
        controller.save();
        System.assert(!controller.isClassAvailable);
    }
	@isTest
    static void testToDeleteClass(){
        Class__c classInstance = [SELECT Id FROM Class__c WHERE Name = 'TestClass1' LIMIT 1];
        PageReference pageRef = Page.ManageClass;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('classId',classInstance.id);
        ClassController controller = new ClassController();
        controller.setClassObject();
        controller.deleteClass();
        System.assert(!controller.isClassAvailable);
        System.assert(!controller.classIdMap.containsKey(classInstance.Id));
    }
}