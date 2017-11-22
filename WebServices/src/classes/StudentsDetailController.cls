public class StudentsDetailController {
    public List<Student__c> listOfStudents { get; set; }
    public Id selectedStudent { get; set; }
    
    public StudentsDetailController(){
        listOfStudents = new StudentsSelector().getListOfStudents();
    }
    public List<SelectOption> getItems(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('null', '---None---'));
        for(Student__c student : listOfStudents){
            options.add(new SelectOption(student.Id, student.Name__c));
        }
        return options;
    }
}