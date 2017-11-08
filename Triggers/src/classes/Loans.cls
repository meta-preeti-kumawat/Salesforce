public class Loans extends fflib_SObjectDomain {

    public Loans(List<Loan__c> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Loans(sObjectList);
        }
    }
    public override void onBeforeInsert() {
       	Set<String> citySet = new Set<String>();
        for(Loan__c loan : (List<Loan__c>) Records) {
            if(loan.City__c != null){
                citySet.add(loan.City__c);
            }
        }
        Map<String, CityManager__c> cityManagerMap = new Map<String, CityManager__c>();
        cityManagerMap = new CityManagersSelector().selectByCity(citySet);
        for(Loan__c loan : (List<Loan__c>) Records) {
            if(loan.City__c != null){
                String cityInLowerCase = loan.City__c.toLowerCase();
                if(cityManagerMap.containsKey(cityInLowerCase)){
                    loan.Manager__c = cityManagerMap.get(cityInLowerCase).Manager__c;
                }
            }
        }
    }
}