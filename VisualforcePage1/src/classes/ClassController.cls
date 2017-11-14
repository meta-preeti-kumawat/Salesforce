public class ClassController {
   
    public Id classId {get; set;}
    public Class__c classToEdit {get; set;}
    public Boolean isClassAvailable{get; set;}
    public Map<Id,Class__C> classIdMap;
    
    public ClassController(){
        hide();
        classIdMap = new ClassesSelector().selectAllAsMap();
    }
    
    public void setClassObject() {
        classId = ApexPages.currentPage().getParameters().get('classId');
        classToEdit = classIdMap.get(classId);
        isClassAvailable = true;
    }
    
    public List<Class__C> getClasses() {
        return classIdMap.values();
    }
    
    /*this method disable the view of editing the object*/
    public void hide() {
        isClassAvailable = false;
    }
    
    public PageReference save(){
        if(classIdMap.containsKey(classId)){
            ClassDAO.updateRecords(new List<Class__c>{classToEdit});
        	   classIdMap.put(classId, classToEdit);
            isClassAvailable = false;
        }
        return null;
    }
    
    public void deleteClass(){
        setClassObject();
        classIdMap.remove(classToEdit.id);
        isClassAvailable = false;
        ClassDAO.deleteRecords(new List<Class__c>{classToEdit});
    }
}
