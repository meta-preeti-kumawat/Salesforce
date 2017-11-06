trigger StopHindiTeacherUpdates on Contact (before insert, before update) {
    if(Trigger.isUpdate){
        for(Contact teacher : Trigger.NEW){
            Contact oldContact = Trigger.oldMap.get(teacher.Id);
            
            Boolean isOldSubjectHindi = oldContact.Subjects__c.contains('Hindi');
            Boolean isNewSubjectHindi = teacher.Subjects__c.contains('Hindi');
            system.debug('Old: '+isOldSubjectHindi);
            system.debug('New '+isNewSubjectHindi);
            if(isOldSubjectHindi || isNewSubjectHindi){
                teacher.addError('Subject Hindi cannot be added or removed');
            }
        } 
    }
    else {
        if(Trigger.isInsert){
            for(Contact teacher : Trigger.NEW){
                Boolean isNewSubjectHindi = teacher.Subjects__c.contains('Hindi');
                if(isNewSubjectHindi){
                    teacher.addError('Hindi Teacher cannot be inserted');
                }
            }
        }
    }
}