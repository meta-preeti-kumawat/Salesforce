public class StudentExtension {
	private final Student__c student;
    
    public StudentExtension(ApexPages.StandardController stdController){
        student = (Student__c)stdController.getRecord();
    }
    
    public PageReference attachPDF(){
        String parentId = ApexPages.currentPage().getParameters().get('id');
        String attachmentName = student.Name+'.pdf';
        deletePreviousAttachment(attachmentName);
        PageReference pdfPage = Page.StudentDetailPDFPage;
        pdfPage.getParameters().put('id',parentId);
        Blob pdfBlob = pdfPage.getContent();
        Attachment attachment = new Attachment(parentId = student.Id, Name = attachmentName, Body = pdfBlob);
        insert attachment;
        
        return null;
    }
    private void deletePreviousAttachment(String attachmentName){
        List<Attachment> listOfAttachments = new AttachmentsSelector().selectByName(new Set<String>{attachmentName});
        if(listOfAttachments.size() > 0){
            Delete listOfAttachments;
        }
    }
    
}