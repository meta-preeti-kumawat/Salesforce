global class EmailScheduler implements Schedulable{
    global void execute(SchedulableContext ctx){
        List<Opportunity> opportunities = [SELECT Name, Owner.email FROM Opportunity WHERE LastModifiedDate < Last_N_Days:30 ];
    	List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
  		System.debug(opportunities.size());
        for(Opportunity opp: opportunities){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        	List<String> sendTo = new List<String>();
        	sendTo.add(opp.Owner.email);
            mail.setToAddresses(sendTo);
            mail.setReplyTo('preeti.kumawat@metacube.com');
		    mail.setSenderDisplayName('System Administrator');
            mail.setSubject('Opportunity not updated for last 30 days');
            String body = 'Dear ' + opp.Owner.name + ',';
            body += 'The Opportunity "'+opp.Name+'" has not been updated for last 30 days';
            body += 'As you are the owner, please check and respond with required action';
            mail.setHtmlBody(body);
            
            mails.add(mail);
        }
        Messaging.sendEmail(mails);
       
    }
}