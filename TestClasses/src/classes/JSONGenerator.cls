public class JSONGenerator {
    public String jsonData { get; set;}
    
    public JSONGenerator(){
        List<Student__c> listOfStudents = new StudentsSelector().getListOfStudents();
        jsonData = JSON.serialize(listOfStudents);
    }
}