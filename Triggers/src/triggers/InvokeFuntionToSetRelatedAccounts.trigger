trigger InvokeFuntionToSetRelatedAccounts on Opportunity (before update) {
	RelatedAccount ra = new RelatedAccount();
   	ra.setRelatedAccounts((List<Opportunity>)Trigger.new);
}