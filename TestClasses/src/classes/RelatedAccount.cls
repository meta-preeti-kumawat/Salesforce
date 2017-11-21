public class RelatedAccount {
   public void setRelatedAccounts(List<Opportunity> opportunity) {
       Set<Id> contactIdSet = new Set<Id>();
       for(Opportunity o : opportunity){
           if (o.BillToContact__c != null && o.Manager__c == null) {
               contactIdSet.add(o.BillToContact__c);
           }
       }
       Map<Id, Id> contactToAccountMapping = new ContactSelector().selectAccountIdByContactId(contactIdSet);
       for (Opportunity o : opportunity) {
           if (o.BillToContact__c != null && o.Manager__c == null) {
               o.Manager__c = contactToAccountMapping.get(o.BillToContact__c);
           }
       }
   }
}