public class ProductsSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Product__c.Id,
            Product__c.Price__c,
            Product__c.Name,    
            Product__c.Product_Code__c,
            Product__c.Type__c,
            Product__c.Product_Description__c
        };
    }
    public Schema.SObjectType getSObjectType(){
        return Product__c.SObjectType;
    }
    public Map<Id, Product__c> selectAllAsMap(){
        Map<Id, Product__c> productMap = new Map<Id, Product__c>(); 
        Database.QueryLocatorIterator iterate =  queryLocatorAllProducts().iterator();
        while(iterate.hasNext()){
            Product__c productInstance = (Product__c)iterate.next();
            productMap.put(productInstance.Id, productInstance);
        }
        return productMap;
    }
   
    public Database.QueryLocator queryLocatorAllProducts(){
       return Database.getQueryLocator(
          newQueryFactory().toSOQL()
       );
    }
    public List<Product__c> selectById(Set<ID> idSet){
        return (List<Product__c>) selectSObjectsById(idSet);
    }
    public List<Product__c> selectAll(){
        return Database.query(newQueryFactory().toSOQL());
    }
}