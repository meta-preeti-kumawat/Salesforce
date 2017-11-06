global class EmailToOwner implements Database.Batchable<sObject>{
      
    global Database.QueryLocator start(Database.BatchableContext ctx){
        return Database.getQueryLocator('SELECT Id, Name, OwnerId, Owner.Email, owner.name FROM Opportunity WHERE LASTMODIFIEDDATE < LAST_N_DAYS : 30');
    	//return Database.getQueryLocator('SELECT Id, Name, OwnerId, Owner.Email, owner.name FROM Opportunity');
    }
    
    global void execute(Database.BatchableContext ctx, List<Opportunity> scope){
        Set<String> userIds = new Set<String>();
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
  		for(Opportunity oppObj : scope){
            if(!userIds.contains(oppObj.Owner.email)){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                List<String> sendTo = new List<String>();
                sendTo.add(oppObj.Owner.email);
                mail.setToAddresses(sendTo);
                mail.setReplyTo('preeti.kumawat@metacube.com');
                mail.setSenderDisplayName('System Administrator');
                mail.setSubject('Opportunity not updated for last 30 days');
                String body = 'Dear ' + oppObj.Owner.name + ',';
                body += 'The Opportunity "'+oppObj.Name+'" has not been updated for last 30 days. ';
                body += 'As you are the owner, please check and respond with required action';
                mail.setHtmlBody(body);
                System.debug(oppObj.Owner.email);
                
            	mails.add(mail);
                userIds.add(oppObj.Owner.email);
            }
        }
        Messaging.sendEmail(mails);																				
    }
    
    global void finish(Database.BatchableContext ctx){
        System.debug('Task Finished');
    }
}