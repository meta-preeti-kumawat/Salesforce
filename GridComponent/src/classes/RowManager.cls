public class RowManager {
    public SoqlQuery soqlQuery { get; set; }
    public ApexPages.StandardSetController stdController;
    public Integer pageSize { get; set; }
    public List<Integer> listOfPageNumbers;
    public List<SObject> rows{
        get{
            this.rows = new List<SObject>();
            for(SObject obj : this.stdController.getRecords()){
	            this.rows.add(obj);
            }
            return this.rows;
        }
        private set;
    }
    public Integer totalPages { get; set; }
    
    public RowManager(SoqlQuery soqlQuery, Integer pageSize){
        this.soqlQuery = soqlQuery;
        this.pageSize = pageSize;
        fetchRows(this.soqlQuery);
        totalPages = Math.ceil(ResultSize / PageSize).intValue();
    }
    
    public void fetchRows(SoqlQuery soqlQuery){
        String query = SoqlQuery.asString();
        stdController = new ApexPages.StandardSetController(Database.getQueryLocator(query));
        stdController.setPageSize(pageSize);
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
        set{
        	this.stdController.setPageNumber(value);
        }  
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
    public List<Integer> previousPageNumbers{
        get{
            List<Integer> pageNumbers = new List<Integer>(); 
            for(Integer i = 3; i > 0; i--){
                if(this.stdController.getPageNumber()-i <= 1){
                    continue;
                }
                pageNumbers.add(this.stdController.getPageNumber()-i);
            }
            return pageNumbers;
        }
    }
    public List<Integer> nextPageNumbers{
        get{
            List<Integer> pageNumbers = new List<Integer>();
            for(Integer i = 1; i <= 3; i++){
                if(this.stdController.getPageNumber()+i >= this.totalPages){
                    break;
                }
                pageNumbers.add(this.stdController.getPageNumber()+i);
            }
            return pageNumbers;
        }
    }
    public void skipToPage(){
        stdController.setPageNumber(this.pageNumber);
    }
}