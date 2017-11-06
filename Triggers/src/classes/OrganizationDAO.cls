public class OrganizationDAO {
    public static List<SObjectType> getAllSObjects(){
       	List<Schema.SObjectType> sObjectList = Schema.getGlobalDescribe().Values();     
        for(SObjectType type : sObjectList){
            System.debug(type);
        }
        return sObjectList; 
    }
}