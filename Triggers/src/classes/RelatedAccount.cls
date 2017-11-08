public class RelatedAccount {
   public void setRelatedAccounts(List<Opportunity> oppty) {
       for (Opportunity o : oppty) {
           if (o.BillToContact__c != null && o.Manager__c == null) {
               o.Manager__c = [SELECT AccountId FROM Contact WHERE Id = :o.BillToContact__c LIMIT 1].AccountId;
           }
       }
   }
}