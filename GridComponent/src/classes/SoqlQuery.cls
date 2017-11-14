public class SoqlQuery {
    private ApexPages.StandardSetController setController;
    public List<String> fieldsList { get; set; }
    public String objectName { get; set; }
    public String fieldNames { get; set; }
    public String sortFieldName { get; set; }
    public Boolean sortDescending { get; set; }
    public Boolean hasOrderByClause { get; set; }
    
    public SoqlQuery(String objectName, String fieldNames){
        this.objectName = objectName.trim();
        sortDescending = false;
        hasOrderByClause = false;
        this.fieldsList = new List<String>();
        
        Schema.DescribeSObjectResult type = null;
        if(Schema.getGlobalDescribe().get(objectName) != null){
            type = Schema.getGlobalDescribe().get(objectName).getDescribe();
        }
        if(type == null){
            throw new InvalidQueryException('SObject with name ' + objectName + ' does not exists.');
        }
        else if(!type.isAccessible()){
            throw new InvalidQueryException('SObject with name ' + objectName + ' is not accessible for current user.');
        }
        selectFields(fieldNames);
    }
    
    public SoqlQuery selectFields(String fieldNames){
        this.fieldNames = fieldNames;
        return selectFields(fieldNames.trim().split(','));
    }
    
    public SoqlQuery selectFields(List<String> newfieldsList){
        Map<String, Schema.SObjectField> fieldsMap = new Map<String, Schema.SObjectField>();
        if(Schema.getGlobalDescribe().get(objectName) != null){
            fieldsMap = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap();
        }
        for(String fieldName : newfieldsList){
            
            Schema.DescribeFieldResult field = fieldsMap.get(fieldName).getDescribe();
            if(field == null){
                throw new InvalidQueryException('Field with name ' + fieldName + ' does not exists in sObject ' + objectName);
            }
            else if(!field.isAccessible()) {
                throw new InvalidQueryException('Field with name ' + fieldName + ' is not accessible for current user');
            }
        }
        this.fieldsList.clear();
        this.fieldsList.addAll(newfieldsList);
        return this;
    }
    
    public SoqlQuery orderBy(String sortFieldName, Boolean sortDescending) {
        this.sortFieldName = sortFieldName.trim();
        this.sortDescending = sortDescending;
        Schema.DescribeFieldResult field = null;
        if(Schema.getGlobalDescribe().get(objectName) != null){
            field = Schema.getGlobalDescribe().get(objectName).getDescribe().fields.getMap().get(sortFieldName).getDescribe();
        }	
        if(field == null) {
            throw new InvalidQueryException('Sort field ' + sortFieldName + ' does not exist on object ' + objectName);
        }
        else if(!field.isSortable()) {
            throw new InvalidQueryException(sortFieldName + ' is not a sortable field.');
        }
        this.hasOrderByClause = true;
        return this;
    }
    
    public String asString(){
        String query = 'SELECT ';
        for(String fieldName : fieldsList){
            query += String.escapeSingleQuotes(fieldName) + ',';
        }
        query = query.substring(0, query.length() - 1);
        query += ' FROM ' + String.escapeSingleQuotes(objectName);
        
        if(hasOrderByClause) {
            query += ' ORDER BY ';
            query += String.escapeSingleQuotes(sortFieldName);
            query += sortDescending ? ' DESC' : ' ASC';
        }
        return query;
    }
    public class InvalidQueryException extends Exception{}
}