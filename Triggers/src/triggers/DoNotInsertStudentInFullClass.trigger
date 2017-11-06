trigger DoNotInsertStudentInFullClass on Student__c (before insert) {
	Set<Id> classIds = new Set<Id>();
    for(Student__c student : Trigger.New){
        classIds.add(student.Class__c);
    }
    Map<ID, Class__c> classData = new map<ID,Class__c>();
    for(Class__c classes : new ClassesSelector().selectById(classIds)){
        classData.put(classes.Id, classes);
    }
    for(Student__c student : Trigger.New){
        Class__c studentClass = classData.get(student.Class__c);
        if(studentClass.NumberOfStudents__c == studentClass.MaxSize__c){
            student.addError('No space for new student');
        }
    }
}