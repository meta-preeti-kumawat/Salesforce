public with sharing class AccountControllerExtension {
    public String SearchBillingCity { get; set;}
    public String SearchBillingState { get; set;}
    public String SearchBillingCountry { get; set;}
    public String query;
    public Integer page_size = 10;
    
    public AccountControllerExtension(ApexPages.StandardSetController stdController){
        this.stdController = stdController;
        this.stdController.setPageSize(page_size);
    }
    public ApexPages.StandardSetController stdController{
        get{
            if(stdController == null){
                stdController =  new ApexPages.StandardSetController(Database.getQueryLocator(query));
                stdController.setPageSize(page_size);
            }
            return stdController;
        }
        set;
    } 
    public List<Account> accounts {
        get{
            if(stdController != null){
                return (List<Account>)stdController.getRecords();
            }
            else{
                return null;
            }
        }
        set;
    }
    public PageReference Search(){
        stdController = null;
        query = 'SELECT Name, BillingCity, BillingState, BillingCountry FROM Account';
        String filterWhere = '';
        
        if(SearchBillingCity != null && SearchBillingCity.trim() != ''){
            filterWhere = ' WHERE BillingCity LIKE \'%'+SearchBillingCity+'%\'';
        }
        if(SearchBillingState != null && SearchBillingState.trim() != ''){
            if(filterWhere == ''){
                filterWhere = ' WHERE BillingState LIKE \'%'+SearchBillingState+'%\'';
            }
            else{
                filterWhere += ' AND BillingState LIKE \'%'+SearchBillingState+'%\'';
            }
        }
        if(SearchBillingCountry != null && SearchBillingCountry.trim() != ''){
            if(filterWhere == ''){
                filterWhere = ' WHERE BillingCountry LIKE \'%'+SearchBillingCountry+'%\'';
            }
            else{
                filterWhere += ' AND BillingCountry LIKE \'%'+SearchBillingCountry+'%\'';
            }
        }
        if(filterWhere != ''){
            query += filterWhere;
        }
       	System.debug(query);
        return null;
    }
}