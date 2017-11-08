public class AttachmentsSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Attachment.Id,
            Attachment.Name,
            Attachment.ParentId
        };
    }
    public Schema.SObjectType getSObjectType(){
        return Attachment.SObjectType;
    }
    public List<Attachment> selectById(Set<ID> idSet){
        return (List<Attachment>) selectSObjectsById(idSet);
    }
    public List<Attachment> selectByName(Set<String> nameSet){
        String query = String.format(
            'SELECT {0} FROM {1} '+
            'WHERE Name IN :nameSet', 
            new List<String> {getFieldListString(), getSObjectName()});
        return (List<Attachment>) Database.query(query);
    }
}