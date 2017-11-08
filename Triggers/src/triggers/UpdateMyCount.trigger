trigger UpdateMyCount on Student__c (after insert, after update, after delete, after undelete) {
	Set<Id> classIds = new Set<Id>();
    List<Class__c> listOfClasses = new List<Class__c>();
    if(Trigger.isInsert || Trigger.isUndelete){
     	for(Student__c student : Trigger.New){
            classIds.add(student.Class__c);
        }
    }
    else{
        if(Trigger.isUpdate){
            for(Student__c student : Trigger.New){
                Student__c oldStudent = Trigger.oldMap.get(student.Id);
                if(oldStudent.Class__c <> student.Class__c){
                	classIds.add(student.Class__c);
                    classIds.add(oldStudent.Class__c);
                }
            }
        }
        else{
            if(Trigger.isDelete){
                for(Student__c student : Trigger.OLD){
                    classIds.add(student.Class__c);
                }
            }
        }
    }	
    
    ClassesSelector cs = new ClassesSelector();
    Map<Id, Integer> studentClassCount = new Map<Id, Integer>();
	studentClassCount = new ClassesSelector().selectStudentCountByClassId(classIds);
 	for(Class__c classes : cs.selectById(classIds)){
        if(studentClassCount.containsKey(classes.Id)){
            classes.MyCount__c = studentClassCount.get(classes.Id);
            listOfClasses.add(classes);
        }
    } 
    update listOfClasses;
}