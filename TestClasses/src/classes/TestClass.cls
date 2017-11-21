@isTest
private class TestClass {
    @isTest
    static void testStudentsByClassId(){
        Class__c cl = new Class__c(Name = 'V', MaxSize__c = 30);
        insert cl;
        Id classId = cl.Id;
        
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer numberOfStudents = 0; numberOfStudents < 30; numberOfStudents++){
            Student__c student = new Student__c(
                First_Name__c = 'First'+numberOfStudents,
                Last_Name__c = 'Last'+numberOfStudents,
                Sex__c = 'Male',
                Class__c = classId
            );
            listOfStudents.add(student);
        }
        insert listOfStudents;
        System.assertEquals(30, ((List<Student__c>)Classes.getStudentsByClassId(cl.Id)).size());
    }
    @isTest
    static void testStudentsOfAllClasses(){
        List<Class__c> listOfClasses = new List<Class__c>();
        List<Student__c> listOfStudents = new List<Student__c>();
        for(Integer numberOfClasses = 0; numberOfClasses < 3; numberOfClasses++ ){
            Class__c cl = new Class__c(Name = 'class'+numberOfClasses, MaxSize__c = 30);
            listOfClasses.add(cl);
        }
        insert listOfClasses;
        
        for(Integer numberOfClasses = 0; numberOfClasses < 3; numberOfClasses++ ){
            Class__c cl = listOfClasses[numberOfClasses];
            
            for(Integer numberOfStudents = 0; numberOfStudents < 30; numberOfStudents++){
                Student__c student = new Student__c(
                    First_Name__c = 'First'+numberOfClasses+' '+numberOfStudents,
                    Last_Name__c = 'Last'+numberOfClasses+' '+numberOfStudents,
                    Sex__c = 'Male',
                    Class__c = cl.Id
                );
                listOfStudents.add(student);
            }
        }
        insert listOfStudents;
        
        Map<Class__c, Set<Student__c>> resultMap = new Map<Class__c, Set<Student__c>>(Classes.getClassMap());
        System.assertEquals(3, resultMap.size());
    }
}