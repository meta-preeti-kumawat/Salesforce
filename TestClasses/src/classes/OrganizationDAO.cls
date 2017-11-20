public class OrganizationDAO {
    public static List<SObjectType> getAllSObjects(){
        List<Schema.SObjectType> sObjectList = Schema.getGlobalDescribe().Values();     
        return sObjectList; 
    }
}