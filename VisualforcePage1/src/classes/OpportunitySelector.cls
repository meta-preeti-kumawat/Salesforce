public class OpportunitySelector extends fflib_SObjectSelector{
    public List<Schema.SObjectField> getSObjectFieldList(){
        return new List<Schema.SObjectField>{
            Opportunity.Id,
            Opportunity.Name,
            Opportunity.BillToContact__c,
            Opportunity.Manager__C
        };
    }
    public Schema.SObjectType getSObjectType(){
        return Opportunity.SObjectType;
    }
    public List<Opportunity> selectById(Set<ID> idSet){
        return (List<Opportunity>) selectSObjectsById(idSet);
    }
}