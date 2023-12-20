public class CreateRecordsFromJSONBatchable implements Database.Batchable<sObject>, Database.Stateful {
    JSONWrapperClass parsedData;
    public Integer countSuccessRecords = 0;

    public CreateRecordsFromJSONBatchable(JSONWrapperClass data) {
        this.parsedData = data;
    }
    
    public List<Lead> start(Database.BatchableContext BC) {
      List<Lead> listOfLeads = [
          SELECT Id 
          FROM Lead 
          LIMIT 1
      ];
        
      return listOfLeads;
   }

    public void execute(Database.BatchableContext BC, List<sObject> scope) {
        try {
            List<Lead> newLeadsList = new List<Lead>();

            for(Integer i = 0; i < parsedData.lead.size(); i++) {
                Lead newLead = new Lead(
                    FirstName = parsedData.lead[i].firstName, 
                    LastName = parsedData.lead[i].lastName,
                    Company = parsedData.lead[i].company,
                    Status = parsedData.lead[i].status
                );
                newLeadsList.add(newLead);
            }

            Database.SaveResult[] insertResults = Database.insert(newLeadsList, false);
            for(database.SaveResult result : insertResults) {
                if(result.isSuccess()) {
                    countSuccessRecords++;
                }
            }
        } catch (Exception e) {
            Record_Created__e createdRecordsEvent = new Record_Created__e();
            createdRecordsEvent.Status__c = 'Error';
            EventBus.publish(createdRecordsEvent);
        }
    }

    public void finish(Database.BatchableContext BC) {
        if(parsedData.lead != null) {
            Record_Created__e createdRecordsEvent = new Record_Created__e();
            createdRecordsEvent.Records_created__c = countSuccessRecords;
            createdRecordsEvent.Records_Failed__c = parsedData.lead.size() - countSuccessRecords;
            createdRecordsEvent.Total_Records_Amount__c = parsedData.lead.size();
            createdRecordsEvent.Status__c = 'Done';
            EventBus.publish(createdRecordsEvent);    
        }  
    }
}