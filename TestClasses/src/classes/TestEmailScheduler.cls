@isTest
private class TestEmailScheduler {
    
    @isTest
    static void testEmail(){
        List<Opportunity> opptys = new List<Opportunity>();
        Date closeDate = Date.today().addDays(-7);
        for (Integer i=0; i<10; i++) {
            Opportunity o = new Opportunity(
                Name = 'Opportunity ' + i,
                CloseDate = closeDate,
                StageName = 'Prospecting'
            );
            opptys.add(o);
        }
        insert opptys;
        
        Test.startTest();
        // Schedule the test job
        OpportunityOwnersMailSchedule mail = new OpportunityOwnersMailSchedule(); 
        String sch = '0 0 23 * * ?'; 
        String jobId = system.schedule('Test Territory Check', sch, mail);         
        
        CronTrigger cron =  [SELECT TimesTriggered FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(0, cron.TimesTriggered);
        Test.stopTest();
    }
}