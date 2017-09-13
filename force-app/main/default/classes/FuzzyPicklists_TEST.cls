@isTest
public class FuzzyPicklists_TEST {
    
    @testSetup static void insertCMDTs() {
    }
    
    @isTest public static void testFPs() {
        String fpjson = '[{"Id":"fpID"';
        fpjson += ',"DeveloperName":"Test"';
        fpjson += ',"Object__c":"Contact"';
        fpjson += ',"Free_Text_Field__c":"Contact.Title"';
        fpjson += ',"Picklist_Field__c":"Contact.LeadSource"';
        fpjson += ',"Match_Last_Evaluated_Date_Time_Field__c":"Contact.LastCURequestDate"';
        fpjson += ',"Text_Last_Populated_Date_Time_Field__c":"Contact.LastCUUpdateDate"';
        fpjson += '}]';
        FuzzyPicklistSelector.fuzzyPicklists = (List<FuzzyPicklist__mdt>) JSON.deserialize(fpjson, List<FuzzyPicklist__mdt>.class );
        system.debug(FuzzyPicklistSelector.fuzzyPicklists);
        String fpvjson = '[{"Id":"fpv1Id"';
        fpvjson += ',"DeveloperName":"Web"';
        fpvjson += ',"Picklist_API_Value__c":"Web"';
        fpvjson += ',"FuzzyPicklist__c":"fpId"}';
        fpvjson += ',{"Id":"fpv2Id"';
        fpvjson += ',"DeveloperName":"Other"';
        fpvjson += ',"Picklist_API_Value__c":"Other"';
        fpvjson += ',"FuzzyPicklist__c":"fpId"';
        fpvjson += '}]';
        FuzzyPicklistSelector.fuzzyPicklistValues = (List<FuzzyPicklistValue__mdt>) JSON.deserialize(fpvjson, List<FuzzyPicklistValue__mdt>.class );
		system.debug(FuzzyPicklistSelector.fuzzyPicklistValues);
        String fppjson = '[{"Id":"fpp1Id"';
        fppjson += ',"DeveloperName":"MatchMeWeb"';
        fppjson += ',"Match_String__c":"MatchMeWeb"';
        fppjson += ',"FuzzyPicklistValue__c":"fpv1Id"}';
        fppjson += ',{"Id":"fpp2Id"';
        fppjson += ',"DeveloperName":"MatchMeWeb2"';
        fppjson += ',"Match_String__c":"MatchMeWeb2"';
        fppjson += ',"FuzzyPicklistValue__c":"fpv1Id"}';
        fppjson += ',{"Id":"fpp3Id"';
        fppjson += ',"DeveloperName":"MatchMeOther"';
        fppjson += ',"Match_String__c":"MatchMeOther"';
        fppjson += ',"FuzzyPicklistValue__c":"fpv2Id"}]';
        FuzzyPicklistSelector.fuzzyPicklistPossibilities = (List<FuzzyPicklistPossibility__mdt>) JSON.deserialize(fppjson, List<FuzzyPicklistPossibility__mdt>.class );
		system.debug(FuzzyPicklistSelector.fuzzyPicklistPossibilities);

        List<Id> recordIds = new List<Id>();
        Contact c = new Contact(LastName='Smith'
                           ,Title='MatchMeWeb');
        insert c;
        List<Contact> cons = [SELECT LeadSource FROM Contact WHERE Id = :c.Id];
        for(Contact con : cons){
            recordIds.add(con.Id);
        }
        //MatchFuzzyPicklists.matchPicklists(recordIds);
        cons = [SELECT LeadSource FROM Contact WHERE Id = :c.Id];
        System.assertEquals('Web',cons[0].LeadSource);
    }
    
}