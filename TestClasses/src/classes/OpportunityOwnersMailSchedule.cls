global class OpportunityOwnersMailSchedule implements Schedulable{
    global void execute(SchedulableContext sc) {
        EmailToOpportunityOwner emailInstance = new EmailToOpportunityOwner();
        Database.executeBatch(emailInstance);
    }
}