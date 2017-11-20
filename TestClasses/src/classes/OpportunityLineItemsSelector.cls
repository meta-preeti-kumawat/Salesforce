public class OpportunityLineItemsSelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            OpportunityLineItem.Id,
            OpportunityLineItem.Opportunity.Id
        };
    }
    public Schema.SObjectType getSObjectType(){
        return OpportunityLineItem.SObjectType;
    }
    public List<OpportunityLineItem> selectById(Set<ID> idSet){
        return (List<OpportunityLineItem>) selectSObjectsById(idSet);
    }
    public List<OpportunityLineItem> selectByOpportunityId(Set<ID> idSet){
        String query = String.format(
            'SELECT {0} from {1} ' + 
            'WHERE Opportunity.Id IN :idSet ',
            new List<String>{ getFieldListString(), getSObjectName() } );
        
        List<OpportunityLineItem> oppLineItemList = Database.query(query);
        return oppLineItemList;
    }
}