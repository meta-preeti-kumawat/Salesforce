trigger LoansTrigger on Loan__c (before insert) {
	fflib_SObjectDomain.triggerHandler(Loans.class);
}