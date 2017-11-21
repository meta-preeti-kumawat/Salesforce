trigger StopHindiTeacherUpdates on Contact (before insert, before update) {
    if(Trigger.isUpdate){
        for(Contact teacher : Trigger.NEW){
            Contact oldContact = Trigger.oldMap.get(teacher.Id);
            Boolean isOldSubjectHindi = false;
            Boolean isNewSubjectHindi = false;
            if(oldContact.Subjects__c!=null){
                isOldSubjectHindi = oldContact.Subjects__c.contains('Hindi');
            }
            if(teacher.Subjects__c!=null){
                isNewSubjectHindi = teacher.Subjects__c.contains('Hindi');
            }
            if(isOldSubjectHindi || isNewSubjectHindi){
                teacher.addError('Subject Hindi cannot be added or removed');
            }
        } 
    }
    else {
        if(Trigger.isInsert){
            for(Contact teacher : Trigger.NEW){
                Boolean isNewSubjectHindi = false;
                if(teacher.Subjects__c!=null){
                    isNewSubjectHindi = teacher.Subjects__c.contains('Hindi');
                    if(isNewSubjectHindi){
                        teacher.addError('Hindi Teacher cannot be inserted');
                    }
                }
            }
        }
    }
}