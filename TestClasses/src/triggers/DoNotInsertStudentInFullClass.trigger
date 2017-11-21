trigger DoNotInsertStudentInFullClass on Student__c (before insert) {
    Set<Id> classIds = new Set<Id>();
    for(Student__c student : Trigger.New){
        classIds.add(student.Class__c);
    }
    Map<ID, Class__c> classData = new map<ID,Class__c>();
    Map<ID, Integer> numberOfStudentsInClass = new Map<Id, Integer>();
    for(Class__c classes : new ClassesSelector().selectById(classIds)){
        classData.put(classes.Id, classes);
        numberOfStudentsInClass.put(classes.Id, classes.NumberOfStudents__c.intValue());
    }
    
    for(Student__c student : Trigger.New){
        Class__c studentClass = classData.get(student.Class__c);
        Integer numberOfStudents = numberOfStudentsInClass.get(student.Class__c);
        if(numberOfStudents == studentClass.MaxSize__c){
            student.addError('No space for new student');
        }
        else{
            numberOfStudentsInClass.put(student.Class__c, numberOfStudents + 1);
        }
    }
}