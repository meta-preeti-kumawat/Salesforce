trigger ResetOpportunity on Opportunity (after update) {
    Set<Id> oppIds = new Set<Id>();
    for(Opportunity opp : Trigger.NEW){
        if(opp.Custom_Status__c == 'Reset'){
            oppIds.add(opp.Id);
        }
    }
    List<OpportunityLineItem> oppLine = new OpportunityLineItemsSelector().selectByOpportunityId(oppIds);
    delete oppLine;
}