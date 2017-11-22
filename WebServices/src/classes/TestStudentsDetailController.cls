@isTest
private class TestStudentsDetailController {
	@testSetup
    static void setup(){
        Class__c classInstance = new Class__c(Name = 'V', MaxSize__c = 30);
        insert classInstance;
        
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer numberOfStudents = 0; numberOfStudents < 5; numberOfStudents++){
            Student__c student = new Student__c(
                First_Name__c = 'First'+numberOfStudents,
                Last_Name__c = 'Last'+numberOfStudents,
                Sex__c = 'Male',
                Class__c = classInstance.Id
            );
            listOfStudents.add(student);
        }
        insert listOfStudents;
    }
    @isTest
    static void testSelectOptionItems(){
        StudentsDetailController controller = new StudentsDetailController();
        System.assertEquals(6, controller.getItems().size());
        System.assert(controller.selectedStudent == null);
    }
}