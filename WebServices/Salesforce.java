import com.sforce.soap.enterprise.Connector;
import com.sforce.soap.enterprise.EnterpriseConnection;
import com.sforce.soap.enterprise.QueryResult;
import com.sforce.soap.enterprise.sobject.Contact;
import com.sforce.soap.enterprise.sobject.SObject;
import com.sforce.soap.enterprise.sobject.Student__c;
import com.sforce.ws.ConnectionException;
import com.sforce.ws.ConnectorConfig;

public class Salesforce {
	static final String USERNAME = "preeti.kumawat@metacube.com";
	static final String PASSWORD = "Peb@235vPCAA68p5sBU6WIVGPRdI5FBFY1";
	static EnterpriseConnection connection;
	
	public static void main(String[] args) {
		ConnectorConfig config = new ConnectorConfig();
		config.setUsername(USERNAME);
		config.setPassword(PASSWORD);
		try {
			connection = Connector.newConnection(config);
			// display some current settings
			System.out.println("Auth EndPoint:"+config.getAuthEndpoint());
			System.out.println("Service EndPoint:"+config.getServiceEndpoint());
			System.out.println("Username: "+config.getUsername());
			System.out.println("SessionId: "+config.getSessionId());
			System.out.println("-------------------------------------------------------------------------");
		} catch (ConnectionException e1) {
			e1.printStackTrace();
		}

		queryContacts();
		insertStudents();
		logout();
	}
	private static void insertStudents() {
		
		Student__c[] students = new Student__c[5];
		for(int count = 0; count < 5; count++){
			Student__c student = new Student__c();
			student.setFirst_Name__c("Fname"+count);
			student.setLast_Name__c("Lname"+count);
			student.setClass__c(getClassForStudent());
			student.setSex__c("Male");
			
			students[count] = student;
		}
		try{
			connection.create(students);
			System.out.println("Students created");
		}
		catch(ConnectionException ce){
			ce.printStackTrace();
		}
		
	}
	private static String getClassForStudent() {
		String soqlQuery = "SELECT Id FROM Class__c LIMIT 1";
		try {
			QueryResult qr = connection.query(soqlQuery);
			if (qr.getSize() > 0) {
				return qr.getRecords()[0].getId();
			} else {
				System.out.println("No records found.");
			}
		} catch (ConnectionException ce) {
			ce.printStackTrace();
		}
		return null;
	}
	private static void logout() {
		try {
			connection.logout();
			System.out.println("Logged out.");
		} catch (ConnectionException ce) {
			ce.printStackTrace();
		}
	}

	private static void queryContacts() {
		String soqlQuery = "SELECT FirstName, LastName FROM Contact";
		try {
			QueryResult qr = connection.query(soqlQuery);
			boolean done = false;

			if (qr.getSize() > 0) {
				System.out.println("\nLogged-in user can see "+ qr.getRecords().length + " contact records.");

				while (!done) {
					System.out.println("");
					SObject[] records = qr.getRecords();
					for (int i = 0; i < records.length; ++i) {
						Contact con = (Contact) records[i];
						String fName = con.getFirstName();
						String lName = con.getLastName();

						if (fName == null) {
							System.out.println("Contact " + (i + 1) + ": " + lName);
						} else {
							System.out.println("Contact " + (i + 1) + ": " + fName
									+ " " + lName);
						}
					}

					if (qr.isDone()) {
						done = true;
					} else {
						qr = connection.queryMore(qr.getQueryLocator());
					}
				}
			} else {
				System.out.println("No records found.");
			}
		} catch (ConnectionException ce) {
			ce.printStackTrace();
		}
	}
}
