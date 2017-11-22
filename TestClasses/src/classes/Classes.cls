public class Classes {
    public static List<Student__c> getStudentsByClassId(Id classId){
        return [SELECT name__c FROM Student__c WHERE Class__r.Id = :classId];
    }
    
    public static Map<Class__c, Set<Student__c>> getClassMap(){
        List<Class__c> listOfClasses= [SELECT Id, (SELECT Id FROM Students__r) FROM Class__c];
        Map<Class__c, Set<Student__c>> classMap = new Map<Class__c, Set<Student__c>>();
        for(Class__c classVar : listOfClasses){
            Set<Student__c> setOfStudents = new Set<Student__c>();
            for(Student__c student : classVar.Students__r){
                setOfStudents.add(student);
            }
            classMap.put(classVar, setOfStudents);
        }
        return classMap;
    }
}