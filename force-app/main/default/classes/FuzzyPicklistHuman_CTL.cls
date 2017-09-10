public class FuzzyPicklistHuman_CTL {
    
    public List<FuzzyPicklist__mdt> fps;
    public List<SelectOption> fpOptions {get; private set;}
    public FuzzyPicklist__mdt selectedFP {get; set;}
    public List<sObject> recordsForFP;
    public List<List<sObject>> recordLists;
    public List<sObject> recordToUpdate {get; set;}
    //public Account account { get; private set; }
    
    public FuzzyPicklistHuman_CTL() {
        this.getAllFuzzyPicklists();
        if(selectedFP==null){
            selectedFP = fps[0];
        }
        //getRecordLists(fps);
        //get all FP_mdt records
        //for each FP_mdt
        //get query string and query records where picklist == null
        //or if dates are not null, where last pop date > last eval date
    }
    
    public List<sObject> getRecordsForFP(){
        return Database.query(FuzzyPicklists.buildBaseQueryString(selectedFP));
    }
    
    public List<FuzzyPicklist__mdt> getAllFuzzyPicklists(){
        if (fps == null) {
            fps = [SELECT Id
                   , DeveloperName 
                   , Object__c
                   , Free_Text_Field__r.QualifiedAPIName
                   , Picklist_Field__r.QualifiedAPIName
                   , Match_Last_Evaluated_Date_Time_Field__r.QualifiedAPIName
                   , Text_Last_Populated_Date_Time_Field__r.QualifiedAPIName
                   FROM FuzzyPicklist__mdt
                  ];
        }
        return fps;
    }
    
    public PageReference save() {
        try {
            update(recordToUpdate);
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        //  After successful Save, navigate to the default view page
        PageReference redirectSuccess = new PageReference('/apex/FuzzyPicklistHuman');
        return (redirectSuccess);
    }
    
}