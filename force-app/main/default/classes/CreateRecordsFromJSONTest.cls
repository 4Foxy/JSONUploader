@isTest
public class CreateRecordsFromJSONTest {
    
    @testSetup static void makeData() {
        Lead newLead = new Lead(
            FirstName = 'TestFirstName',
            LastName = 'TestLastName',
            Company = 'TestCompany',
            Status = 'Closed - Not Converted',
            Email = 'test@gmail.com'
        );
        
        insert newLead;
    }
    
	@isTest
    static void testHandleJSONFile_InsertAllLeadRecords_SuccessResult() {
        Test.startTest();
        CreateRecordsFromJSONController.handleJSONFile(Constants.VALID_MOCK_JSON_DATA);
        Test.stopTest();
        
        List<Lead> createdLeadsList = [
            SELECT Id, CreatedDate 
            FROM Lead 
            WHERE CreatedDate = TODAY
            AND Email = ''
        ];
        
        Assert.areEqual(3, createdLeadsList.size());
    }
    
    @isTest
    static void testHandleJSONFile_InsertPartOfLeadRecords_SuccessResult() {        
        Test.startTest();
        CreateRecordsFromJSONController.handleJSONFile(Constants.VALID_MOCK_JSON_DATA_WITHOUT_COMPANY_NAME);
        Test.stopTest();
        
        List<Lead> createdLeadsList = [
            SELECT Id, CreatedDate 
            FROM Lead 
            WHERE CreatedDate = TODAY
            AND Email = ''
        ];
        
        Assert.areEqual(1, createdLeadsList.size());
    }
    
    @isTest
    static void testHandleJSONFile_InsertLeadRecords_ErrorResult() {        
        Test.startTest();
        try {
         	CreateRecordsFromJSONController.handleJSONFile(Constants.INVALID_MOCK_JSON_DATA);   
        } catch (Exception e) {
            Assert.isNotNull(e.getMessage());
        }
        Test.stopTest();
    }
    
    @isTest
    static void testHandleJSONFile_BAD_JSON_STRUCTURE_ErrorResult() {        
        Test.startTest();
        try {
         	CreateRecordsFromJSONController.handleJSONFile(Constants.INVALID_MOCK_JSON_STRUCTURE);   
        } catch (Exception e) {
            Assert.isNotNull(e.getMessage());
        }
        Test.stopTest();
    }
}