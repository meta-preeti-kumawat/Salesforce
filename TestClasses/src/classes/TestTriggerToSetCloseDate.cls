@isTest
private class TestTriggerToSetCloseDate {
    @testSetup
    static void setup(){
        List<Opportunity> listOfOpportunities = new List<Opportunity>();
        Date closeDate = Date.today().addDays(-7);
        for(Integer opportunityCount = 0; opportunityCount < 5; opportunityCount++){
            Opportunity opportunityProspecting = new Opportunity( Name = 'OpportunityP ' + opportunityCount,
                                                                 CloseDate = closeDate,
                                                                 StageName = 'Prospecting'
                                                                );
            listOfOpportunities.add(opportunityProspecting);
        }
        insert listOfOpportunities;
    }
    @isTest
    static void testTriggerOnOpportunity(){
        List<Opportunity> listOfOpportunities = new List<Opportunity>();
        Date closeDate = Date.today().addDays(-7);
        for(Integer opportunityCount = 0; opportunityCount < 5; opportunityCount++){
            Opportunity opportunityClosedWon = new Opportunity( Name = 'OpportunityCW ' + opportunityCount,
                                                               CloseDate = closeDate,
                                                               StageName = 'Closed Won'
                                                              );
            listOfOpportunities.add(opportunityClosedWon);
            Opportunity opportunityClosedLost = new Opportunity( Name = 'OpportunityCL ' + opportunityCount,
                                                                CloseDate = closeDate,
                                                                StageName = 'Closed Lost'
                                                               );
            listOfOpportunities.add(opportunityClosedLost);
        }
        for(Opportunity opportunity : [SELECT Id, StageName FROM Opportunity WHERE Name LIKE 'OpportunityP%']){
            opportunity.StageName = 'Closed Won';
            listOfOpportunities.add(opportunity);
        }
        System.assertEquals(Date.today().addDays(-7), [SELECT CloseDate FROM Opportunity WHERE Name LIKE 'OpportunityP%' LIMIT 1].CloseDate);
        Test.startTest();
        upsert listOfOpportunities;
        Test.stopTest();
        System.assertEquals(Date.today(), [SELECT CloseDate FROM Opportunity WHERE Name LIKE 'OpportunityCL%' LIMIT 1].CloseDate);
        System.assertEquals(Date.today(), [SELECT CloseDate FROM Opportunity WHERE Name LIKE 'OpportunityCW%' LIMIT 1].CloseDate);
        System.assertEquals(Date.today(), [SELECT CloseDate FROM Opportunity WHERE Name LIKE 'OpportunityP%' LIMIT 1].CloseDate);
    }
}