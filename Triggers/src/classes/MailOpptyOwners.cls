global class MailOpptyOwners implements Schedulable{
   	global void execute(SchedulableContext sc) {
        System.debug('Schedulable');
       	EmailToOwner eto = new EmailToOwner();
        Database.executeBatch(eto);
 	}
}