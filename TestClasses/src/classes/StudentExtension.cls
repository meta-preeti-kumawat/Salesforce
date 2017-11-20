public class StudentExtension {
	private final Student__c student;
    
    public StudentExtension(ApexPages.StandardController stdController){
        student = (Student__c)stdController.getRecord();
    }
    
    public PageReference attachPDF(){
        String parentId = student.Id;
        String attachmentName = student.Name+'.pdf';
        deletePreviousAttachment(attachmentName);
        PageReference pdfPage = Page.StudentDetailPDFPage;
        pdfPage.setRedirect(false);
        pdfPage.getParameters().put('id',parentId);
        Blob pdfBlob;
        if(!test.isRunningTest()){
            pdfBlob = pdfPage.getContent();
        }else{
            pdfBlob = blob.valueof('TEST');
        }
        Attachment attachment = new Attachment(parentId = student.Id, Name = attachmentName, Body = pdfBlob);
        insert attachment;
        
        return null;
    }
    @testVisible
    private void deletePreviousAttachment(String attachmentName){
        List<Attachment> listOfAttachments = new AttachmentsSelector().selectByName(new Set<String>{attachmentName});
        if(listOfAttachments.size() > 0){
            Delete listOfAttachments;
        }
    }
    
}