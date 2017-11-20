public class GridController {
    public String fieldsParam { get; set; }
    public String typeParam { get; set; }
    public String sortByParam { get; set; }
    public Boolean sortDescParam { get; set; }
    public Integer pageSizeParam { get; set; }
    public String previousSortFieldName { get; set; }
    public SoqlQuery soqlQuery { get; set; }
    public RowManager rowManager { get; set; }
    
    public Integer totalSize;
    public Integer counter = 0;
        
    public void getInit(){
        typeParam = typeParam.trim();
        fieldsParam = fieldsParam.trim();
        
        soqlQuery = new SoqlQuery(typeParam, fieldsParam);
        if(sortByParam != null) {
            soqlQuery.orderBy(sortByParam, sortDescParam == null ? false : sortDescParam);
        } 
        
        rowManager = new RowManager(soqlQuery, pageSizeParam);
        previousSortFieldName = SoqlQuery.sortFieldName;
    }
    public void doSort(){
        if(soqlQuery.sortFieldName == previousSortFieldName) {
            soqlQuery.sortDescending = !soqlQuery.sortDescending;
        }
        else {
            soqlQuery.sortDescending = false;
        }
        
        rowManager.fetchRows(soqlQuery);
        previousSortFieldName = soqlQuery.sortFieldName;
    }
}