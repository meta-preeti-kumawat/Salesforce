public class BillToContactController {
   
    private final Opportunity opportunity;
    public Id contactId {get; set;}
    private final PageReference redirectPage;
    private boolean isOpportunityAvailable;
    private List<Opportunity> listOfOpportunitiesToUpdate = new List<Opportunity>();
        
    public BillToContactController(){
        Set<Id> setOfOpportunityId = new Set<Id>();
        setOfOpportunityId.add(ApexPages.currentPage().getParameters().get('id'));
        List<Opportunity> listOfOpportunities = new OpportunitySelector().selectById(setOfOpportunityId);
        if(listOfOpportunities.size() > 0){
            isOpportunityAvailable = true;
            opportunity = listOfOpportunities[0];
            contactId = opportunity.BillToContact__c;
            redirectPage = new ApexPages.StandardController(opportunity).view();
        }
        else{
            isOpportunityAvailable = false;
            redirectPage = new PageReference('/006/o'); 
        }
    }
    
    public List<SelectOption> getListOfContacts(){
        Set<Id> setOfAccountId = new Set<Id>();
        List<SelectOption> listOfOptions = new List<SelectOption>();
        if(isOpportunityAvailable && opportunity.Manager__c!=null) {
            setOfAccountId.add(opportunity.Manager__c);
            List<Contact> listOfContacts = new ContactSelector().selectByAccountId(setOfAccountId) ;
            
            for(Contact contact : listOfContacts){
                listOfOptions.add(new SelectOption(contact.Id, contact.Name));
            }
        }
        if(listOfOptions.size() == 0){
            return null;
        }
        return listOfOptions;
    }
    
    public PageReference clear(){
        if(isOpportunityAvailable){
            opportunity.BillToContact__c = null;
            listOfOpportunitiesToUpdate.add(opportunity);
        }
        OpportunityDAO.updateRecords(listOfOpportunitiesToUpdate);
        return redirectPage;
    }
    
    public PageReference save(){
        if(isOpportunityAvailable){
            opportunity.BillToContact__c = contactId;        
            listOfOpportunitiesToUpdate.add(opportunity);
        }
        OpportunityDAO.updateRecords(listOfOpportunitiesToUpdate);
        return redirectPage;
    }
    
    public PageReference cancel(){
        return redirectPage;       
    }
}
