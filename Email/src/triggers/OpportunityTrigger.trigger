trigger OpportunityTrigger on Opportunity (before update) {
    EmailTemplate template = [SELECT Id, Name FROM EmailTemplate WHERE Name ='OpportunityDetailsMail' and isActive = true Limit 1];
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    for(Opportunity opportunity : Trigger.NEW){
        Opportunity oldOpportunity = Trigger.oldMap.get(opportunity.Id);
        if(oldOpportunity.Custom_Status__c != opportunity.Custom_Status__c){
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setReplyTo('preeti.kumawat@metacube.com');
            mail.setTemplateId(template.Id);
            mail.setTargetObjectId(opportunity.OwnerId);
            mail.setSaveAsActivity(false);
            mails.add(mail);
        }
    }
    if(mails.size() > 0){
        Messaging.sendEmail(mails);		 
    }
}