@isTest
private class TestTriggerToResetOpportunity {
    @testSetup
    static void setup(){
        List<Opportunity> listOfOpportunities = new List<Opportunity>();
        Date closeDate = Date.today().addDays(-7);
        for(Integer opportunityCount = 0; opportunityCount < 5; opportunityCount++){
            Opportunity opportunityProspecting = new Opportunity( Name = 'Opportunity' + opportunityCount,
                                                                 CloseDate = closeDate,
                                                                 StageName = 'Prospecting'
                                                                );
            listOfOpportunities.add(opportunityProspecting);
        }
        insert listOfOpportunities;
        Product2 product = new Product2(Name = 'Product1');
        insert product;
        
        PricebookEntry priceBookEntry = new PricebookEntry(Pricebook2Id = Test.getStandardPricebookId(),
                                                           Product2Id = product.Id, 
                                                           IsActive = true,
                                                           UseStandardPrice = false, 
                                                           UnitPrice = 100);
        insert priceBookEntry;
        
        List<OpportunityLineItem> listOfOpportunityLineItem = new List<OpportunityLineItem>();
        for(Opportunity opportunity : listOfOpportunities){
            for(Integer productCount = 0; productCount < 5; productCount++){
                OpportunityLineItem opportunityLineItem = new OpportunityLineItem( OpportunityId = opportunity.Id,
                                                                                  PricebookEntryId = priceBookEntry.Id,
                                                                                  Quantity = 5,
                                                                                  UnitPrice = 10
                                                                                 );
                listOfOpportunityLineItem.add(opportunityLineItem);
            }
        }
        insert listOfOpportunityLineItem;
    }
    
    @isTest
    static void testTriggerOnOpportunity(){
        List<Opportunity> listOfOpportunities = new List<Opportunity>();
        for(Opportunity opportunity : [SELECT Id, Custom_Status__c, (SELECT Id FROM OpportunityLineItems) 
                                       FROM Opportunity WHERE Name LIKE 'Opportunity%'])
        {
            System.assert(!(opportunity.OpportunityLineItems.size() == 0));
            opportunity.Custom_Status__c = 'Reset';
            listOfOpportunities.add(opportunity);
        }
        
        Test.startTest();
        update listOfOpportunities;
        Test.stopTest();
        for(Opportunity opportunity : listOfOpportunities){
            System.assert(opportunity.OpportunityLineItems.size() == 0);
        }
    }
}