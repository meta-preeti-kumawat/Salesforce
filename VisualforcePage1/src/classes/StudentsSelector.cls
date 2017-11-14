public class StudentsSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Student__c.Id,
            Student__c.Name,
            Student__c.First_Name__c,
            Student__c.Last_Name__c,
            Student__c.Class__c,    
            Student__c.Sex__c	
        };
    }
    public Schema.SObjectType getSObjectType(){
        return Student__c.SObjectType;
    }
    public List<Student__c> selectById(Set<ID> idSet){
        return (List<Student__c>) selectSObjectsById(idSet);
    }
    public List<Student__c> getListOfStudents(){
        return Database.query(newQueryFactory().toSOQL());
    }
}