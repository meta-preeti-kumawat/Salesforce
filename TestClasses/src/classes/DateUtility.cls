public class DateUtility {
    
    private static final List<Boolean> isWorking = new List<Boolean>{True, True, True, True, True, False, False};
        private static final Integer workingDaysInWeek = 5;
    
    public static Integer getWorkingDaysBetween(Date startDate, Date EndDate){
        if(workingDaysInWeek== 0 || startDate == null || EndDate == null){
            return 0;
        }
        if(startDate > EndDate){
            Date tempDate = startDate;
            startDate = EndDate;
            EndDate = tempDate;
        }
        Integer totalDays = startDate.daysBetween(EndDate);
        if(totalDays == 0){
            return isWorking[getDayOfWeek(startDate)] ? 1 : 0;
        } else {
            Integer wholeWeeks = Math.floor(totalDays / 7).intValue();
            Integer workingDays = wholeWeeks * workingDaysInWeek;
            
            Integer dayOfWeek = getDayOfWeek(endDate);
            for(Integer remainder = Math.mod(totalDays, 7); remainder >= 0; remainder--){
                if(isWorking[dayOfWeek]){
                    workingDays++;
                }
                dayOfWeek--;
                if(dayOfWeek < 0){
                    dayOfWeek = 6;
                }
            }
            return workingDays;
        }   
    }
    private static final Date fixedMonday = Date.newInstance(1900, 1, 1);
    
    private static Integer getDayOfWeek(Date value){
        return Math.mod(fixedMonday.daysBetween(value), 7);
    }
}