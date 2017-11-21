public class AccountsController {
    public AggregateResult[] results { 
        get{
            return 
                [
                    SELECT AccountId accId, SUM(Amount) OpportunityAmountSum, COUNT(Id) OpportunityAmountCount 
                    FROM Opportunity 
                    GROUP BY AccountId
                    LIMIT 10
                ];
        } 
        private set; 
    }
}