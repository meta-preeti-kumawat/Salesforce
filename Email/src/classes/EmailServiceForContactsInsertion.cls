global class EmailServiceForContactsInsertion implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envolope){
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        try{
            if(email.binaryAttachments != null && email.binaryAttachments.size() > 0){
                for(Messaging.InboundEmail.BinaryAttachment attachment : email.binaryAttachments){
                    if(attachment.filename.endsWith('.xml')){
                        DOM.Document document = new DOM.Document();
                        document.load(attachment.body.toString());
                        DOM.XmlNode root = document.getRootElement();
                        if(root.getName() == 'contacts'){
                            List<Contact> listOfContacts = new List<Contact>();
                            for(DOM.XmlNode contact : root.getChildElements()){
                                if(contact.getName() == 'contact'){
                                    Contact contactRecord = new Contact();
                                    contactRecord.FirstName = contact.getChildElement('fname', null).getText();
                                    contactRecord.LastName = contact.getChildElement('lname', null).getText();
                                    contactRecord.Department = contact.getChildElement('department', null).getText();
                                    contactRecord.MobilePhone = contact.getChildElement('mobile', null).getText();
                                    contactRecord.Email = contact.getChildElement('email', null).getText();
                                    listOfContacts.add(contactRecord);
                                }
                            }
                            if(listOfContacts.size() > 0){
                                insert listOfContacts;
                            }
                        }
                    }
                }
            }
        }
        catch(Exception exc){
            result.success = false;
            result.message = 'Unable to add contacts to org: ';
        }
        return result;
    }
}