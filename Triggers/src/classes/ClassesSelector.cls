public class ClassesSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Class__c.Id,
            Class__c.NumberOfStudents__c,
            Class__c.MaxSize__c,    
            Class__c.MyCount__c,
            Class__c.ClassTeacher__c
        };
    }
    public Schema.SObjectType getSObjectType(){
        return Class__c.SObjectType;
    }
    public List<Class__c> selectById(Set<ID> idSet){
        return (List<Class__c>) selectSObjectsById(idSet);
    }
    public Map<Id, Integer> selectStudentCountByClassId(Set<Id> classIdSet){
        Map<Id, Integer> studentClassMap = new Map<Id, Integer>();
        String query = String.format(
            'SELECT {0}, (SELECT Id FROM Students__r) from {1} ' + 
            'WHERE Id IN :classIdSet ',
            new List<String>{ getFieldListString(), getSObjectName() } );
        
        List<Class__c> classList = Database.query(query);
        
        for(Class__c cm : classList){
            studentClassMap.put(cm.Id, cm.Students__r.size());
        }
        return studentClassMap;
    }
    public Map<Id, Integer> selectFemaleStudentCountByClassId(Set<Id> classIdSet){
        Map<Id, Integer> studentClassMap = new Map<Id, Integer>();
        String Female = 'Female';
        String query = String.format(
            'SELECT {0}, (SELECT Id FROM Students__r WHERE Sex__c = :\'Female\') from {1} ' + 
            'WHERE Id IN :classIdSet ',
            new List<String>{ getFieldListString(), getSObjectName() } );
        
        List<Class__c> classList = Database.query(query);
        
        for(Class__c cm : classList){
            studentClassMap.put(cm.Id, cm.Students__r.size());
        }
        return studentClassMap;
    }

}