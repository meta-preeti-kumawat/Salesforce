trigger DoNotDeleteClassWithMoreThanOneFemaleStudents on Class__c (before delete) {
    Map<Id, Integer> classFemaleCount = new ClassesSelector().selectFemaleStudentCountByClassId(Trigger.oldMap.keySet());
    for(Class__c classData : Trigger.OLD){
        if(classFemaleCount.get(classData.Id) > 1){
            classData.addError('Cannot delete this class. More than one female students study here');
        }
    }
}