public class CreateRecordsFromJSONController {
    
    @AuraEnabled
    public static void handleJSONFile(String JSONdata) {
        try {
            JSONWrapperClass parsedData = JSONWrapperClass.parse(JSONdata);
            CreateRecordsFromJSONBatchable batchJob = new CreateRecordsFromJSONBatchable(parsedData);
            Database.executeBatch(batchJob, 200);
        } catch (Exception e) {
            Record_Created__e createdRecordsEvent = new Record_Created__e();
            createdRecordsEvent.Status__c = 'Error';
            EventBus.publish(createdRecordsEvent);   
        } 
    }
}