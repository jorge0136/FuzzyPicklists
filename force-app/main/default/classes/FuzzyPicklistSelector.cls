public class FuzzyPicklistSelector {
    
	public static List<FuzzyPicklist__mdt> fuzzyPicklistsOfObject (String obj){
        if(fuzzyPicklists == null){
            List<FuzzyPicklist__mdt> fps = [SELECT Id
                                            , DeveloperName 
                                            , Object__c
                                            , Free_Text_Field__c
                                            , Picklist_Field__c
                                            , Match_Last_Evaluated_Date_Time_Field__c
                                            , Text_Last_Populated_Date_Time_Field__c
                                            , Free_Text_Field__r.QualifiedAPIName
                                            , Picklist_Field__r.QualifiedAPIName
                                            , Match_Last_Evaluated_Date_Time_Field__r.QualifiedAPIName
                                            , Text_Last_Populated_Date_Time_Field__r.QualifiedAPIName
                                            FROM FuzzyPicklist__mdt
                                            WHERE Object__c = :obj];
            return fps;
        } else {
            return fuzzyPicklists;
        }
    }
    
    @testvisible public static List<FuzzyPicklist__mdt> fuzzyPicklists { 
        get {
            if ( fuzzyPicklists == null ) {
                fuzzyPicklists = [SELECT Id
                                  , DeveloperName 
                                  , Object__c
                                  , Free_Text_Field__c
                                  , Picklist_Field__c
                                  , Match_Last_Evaluated_Date_Time_Field__c
                                  , Text_Last_Populated_Date_Time_Field__c
                                  , Free_Text_Field__r.QualifiedAPIName
                                  , Picklist_Field__r.QualifiedAPIName
                                  , Match_Last_Evaluated_Date_Time_Field__r.QualifiedAPIName
                                  , Text_Last_Populated_Date_Time_Field__r.QualifiedAPIName
                                  FROM FuzzyPicklist__mdt]; 
            }
            return fuzzyPicklists;
        } set; }   
    
	public static List<FuzzyPicklistValue__mdt> fuzzyPicklistValuesOfFPs (List<FuzzyPicklist__mdt> fps){
        if(fuzzyPicklistValues != null){
            return fuzzyPicklistValues;
        } else {
            List<FuzzyPicklistValue__mdt> fpvs = [SELECT Id
                                       , DeveloperName
                                       , Picklist_API_Value__c
                                       , FuzzyPicklist__c
                                       FROM FuzzyPicklistValue__mdt
                                       WHERE FuzzyPicklist__c IN :fps];
            return fpvs;
        }
    }
            
    @testvisible public static List<FuzzyPicklistValue__mdt> fuzzyPicklistValues { 
        get {
            if ( fuzzyPicklistValues == null )
                fuzzyPicklistValues = [SELECT Id
                                       , DeveloperName
                                       , Picklist_API_Value__c
                                       , FuzzyPicklist__c
                                       FROM FuzzyPicklistValue__mdt
                                       WHERE FuzzyPicklist__c IN :fuzzyPicklists]; 
            return fuzzyPicklistValues;
        } set; }   
    
	public static List<FuzzyPicklistPossibility__mdt> fuzzyPicklistPossibilitiesOfFPVs (List<FuzzyPicklistValue__mdt> fpvs){
        if(fuzzyPicklistPossibilities != null){
            return fuzzyPicklistPossibilities;
        } else {
            List<FuzzyPicklistPossibility__mdt> fpps = [SELECT Id
                                              , DeveloperName
                                              , Match_String__c  
                                              , FuzzyPicklistValue__c
                                              FROM FuzzyPicklistPossibility__mdt
                                              WHERE FuzzyPicklistValue__c IN :fpvs];
            return fpps;
        }
    }
            
    @testvisible public static List<FuzzyPicklistPossibility__mdt> fuzzyPicklistPossibilities { 
        get {
            if ( fuzzyPicklistPossibilities == null )
                fuzzyPicklistPossibilities = [SELECT Id
                                              , DeveloperName
                                              , Match_String__c  
                                              , FuzzyPicklistValue__c
                                              FROM FuzzyPicklistPossibility__mdt
                                              WHERE FuzzyPicklistValue__c IN :fuzzyPicklistValues]; 
            return fuzzyPicklistPossibilities;
        } set; }   
    
}