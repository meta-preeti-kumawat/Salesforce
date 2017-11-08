@isTest
private class TestDateUtility {
    @isTest
    static void testWorkingDaysForCorrectDateSequence(){
        Date startDate = Date.newInstance(2017, 10, 31);
		Date endDate = Date.newInstance(2017, 11, 6);
        System.assertEquals(5, DateUtility.getWorkingDaysBetween(startDate, endDate));
    }
    @isTest
    static void testWorkingDaysForReverseDateSequence(){
        Date startDate = Date.newInstance(2017, 10, 22);
		Date endDate = Date.newInstance(2017, 10, 6);
        System.assertEquals(11, DateUtility.getWorkingDaysBetween(startDate, endDate));
    }
    @isTest
    static void testWorkingDaysForOneWorkingDay(){
        Date startDate = Date.newInstance(2017, 10, 3);
		Date endDate = Date.newInstance(2017, 10, 3);
        System.assertEquals(1, DateUtility.getWorkingDaysBetween(startDate, endDate));
    }  
    @isTest
    static void testWorkingDaysForOneNonWorkingDay(){
        Date startDate = Date.newInstance(2017, 10, 1);
		Date endDate = Date.newInstance(2017, 10, 1);
        System.assertEquals(0, DateUtility.getWorkingDaysBetween(startDate, endDate));
    }
    @isTest
    static void testForNullDates(){
        Date startDate = Date.newInstance(2017, 10, 3);
		Date endDate;
        System.assertEquals(0, DateUtility.getWorkingDaysBetween(startDate, endDate));
    }
}