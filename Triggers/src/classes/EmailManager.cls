public class EmailManager {
// Public method
  public static void sendMail(String address, String subject, String body) {
     // Create an email message object
     Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
     String[] toAddresses = new String[] {address};
     mail.setToAddresses(toAddresses);
     mail.setSubject(subject);
     mail.setPlainTextBody(body);
     // Pass this email message to the built-in sendEmail method 
     // of the Messaging class
      Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
  }
  public static void sendMails(List<Messaging.SingleEmailMessage> mails) {
      Messaging.sendEmail(mails);																																		
  }
}