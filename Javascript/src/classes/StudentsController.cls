public class StudentsController {
    public List<Student__c> selectedStudents { get; set; }
    public Set<Id> SetOfStudentIds { get; private set; }
    public String stringIds { get; set; }
    public StudentsController(){
        selectedStudents= new List<Student__c>();
        SetOfStudentIds = new Set<Id>();
        for(String studentId : ApexPages.currentPage().getParameters().get('ids').split(',')){
            SetOfStudentIds.add(studentId);
        }
        selectedStudents = new StudentsSelector().selectById(SetOfStudentIds);
        stringIds = JSON.serialize(SetOfStudentIds);
    }
}