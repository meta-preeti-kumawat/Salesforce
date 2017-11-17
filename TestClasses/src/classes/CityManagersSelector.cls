public class CityManagersSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            CityManager__c.Id,
            CityManager__c.City__c,    
            CityManager__c.Manager__c
        };
    }
    public Schema.SObjectType getSObjectType(){
        return CityManager__c.SObjectType;
    }
    public List<CityManager__c> selectById(Set<ID> idSet){
        return (List<CityManager__c>) selectSObjectsById(idSet);
    }
    public Map<String, CityManager__c> selectByCity(Set<String> citySet){
        //assertIsAccessible();
        Map<String, CityManager__c> cityManagerMap = new Map<String, CityManager__c>();
        String query = String.format(
            'SELECT {0} from {1} ' + 
            'WHERE city__c IN :citySet ',
            new List<String>{ getFieldListString(), getSObjectName() } );
        
        List<CityManager__c> cityManagerList = Database.query(query);
        
        for(CityManager__c cm : CityManagerList){
            cityManagerMap.put(cm.city__c.toLowerCase(), cm);
        }
        return cityManagerMap;
    }
}