@isTest
private class TestGridController {
	@isTest
    static void testInitMethod(){
        GridController controller = new GridController();
        controller.typeParam = 'Student__c';
        controller.fieldsParam = 'Id,Name,Name__c';
        controller.sortByParam = 'Name__c';
        controller.pageSizeParam = 5;
        controller.getInit();
    }
    @isTest
    static void testInitMethodForInvalidObjectName(){
        GridController controller = new GridController();
        controller.typeParam = 'Student';
        controller.fieldsParam = 'Id';
        controller.pageSizeParam = 5;
        try{
            controller.getInit();
        }
        catch(Exception exc){
            System.assertEquals('SObject with name ' + controller.typeParam + ' does not exists.', exc.getMessage());
        }
    }
    @isTest
    static void testSortMethodByDesc(){
        GridController controller = new GridController();
        controller.typeParam = 'Student__c';
        controller.fieldsParam = 'Id,Name,Name__c';
        controller.sortByParam = 'Name__c';
        controller.pageSizeParam = 5;
        controller.getInit();
        controller.doSort();
    }
    @isTest
    static void testSortMethod(){
        GridController controller = new GridController();
        controller.typeParam = 'Student__c';
        controller.fieldsParam = 'Id,Name,Name__c';
        controller.sortByParam = 'Name__c';
        controller.pageSizeParam = 5;
        controller.getInit();
        controller.soqlQuery.sortFieldName = 'Id';
        controller.doSort();
    }
}