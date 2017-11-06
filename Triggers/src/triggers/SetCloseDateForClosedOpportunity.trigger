trigger SetCloseDateForClosedOpportunity on Opportunity (before insert, before update) {
    for(Opportunity opp : Trigger.NEW){
        if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost'){
            opp.CloseDate = Date.TODAY();
        }
    }
}