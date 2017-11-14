public with sharing class AccountControllerPaginationExtension {
    public String SearchBillingCity { get; set;}
    public String SearchBillingState { get; set;}
    public String SearchBillingCountry { get; set;}
    public String query;
    
    public AccountControllerPaginationExtension(ApexPages.StandardSetController stdController){
        this.stdController = stdController;
        this.stdController.setPageSize(10);
    }
    public ApexPages.StandardSetController stdController{
        get{
            if(stdController == null){
                stdController =  new ApexPages.StandardSetController(Database.getQueryLocator(query));
                stdController.setPageSize(10);
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
       	return null;
    }
    public Boolean hasNext  
    {  
        get  
        {  
            return stdController.getHasNext();  
        }  
        set;  
    }  
    public Boolean hasPrevious  
    {  
        get  
        {  
            return stdController.getHasPrevious();  
        }  
        set;  
    }  
    public Integer pageNumber  
    {  
        get  
        {  
            return stdController.getPageNumber();  
        }  
        set;  
    }   
    public Integer resultSize  
    {  
        get  
        {  
            return stdController.getResultSize();  
        }  
        set;  
    } 
    public void previous()  
    {  
        stdController.previous();  
    }  
    public void last()  
    {  
        stdController.last();  
    } 
    public void first()  
    {  
        stdController.first();  
    } 
    public void next()  
    {  
        stdController.next();  
    }  
}
