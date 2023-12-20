public class Constants {
    
    public static final String VALID_MOCK_JSON_DATA = 
        '{' +
        '    "lead": [' +
        '        {' +
        '            "firstName": "Clywd",' +
        '            "lastName": "Ilewicz",' +
        '            "company": "Shufflester",' +
        '            "status": "Closed - Converted"' +
        '        },' +
        '        {' +
        '            "firstName": "Quinn",' +
        '            "lastName": "Czapla",' +
        '            "company": "Edgeclub",' +
        '            "status": "Closed - Converted"' +
        '        },' +
        '        {' +
        '            "firstName": "Benedetta",' +
        '            "lastName": "Ames",' +
        '            "company": "Divavu",' +
        '            "status": "Closed - Not Converted"' +
        '        }' +
        '    ]' +
        '}';
    
    	public static final String VALID_MOCK_JSON_DATA_WITHOUT_COMPANY_NAME = 
            '{' +
            '    "lead": [' +
            '        {' +
            '            "firstName": "Clywd",' +
            '            "lastName": "Ilewicz",' +
            '            "status": "Closed - Converted"' +
            '        },' +
            '        {' +
            '            "firstName": "Quinn",' +
            '            "lastName": "Czapla",' +
            '            "status": "Closed - Converted"' +
            '        },' +
            '        {' +
            '            "firstName": "Benedetta",' +
            '            "lastName": "Ames",' +
            '            "company": "Divavu",' +
            '            "status": "Closed - Not Converted"' +
            '        }' +
            '    ]' +
            '}';
    
    	public static final String INVALID_MOCK_JSON_STRUCTURE = 
            '[{' +
            '    "lead": [' +
            '        {' +
            '            "firstName": "Clywd",' +
            '            "lastName": "Ilewicz",' +
            '            "company": "Shufflester",' +
            '            "status": "Closed - Converted"' +
            '        },' +
            '        {' +
            '            "firstName": "Quinn",' +
            '            "lastName": "Czapla",' +
            '            "company": "Edgeclub",' +
            '            "status": "Closed - Converted"' +
            '        },' +
            '        {' +
            '            "firstName": "Benedetta",' +
            '            "lastName": "Ames",' +
            '            "company": "Divavu",' +
            '            "status": "Closed - Not Converted"' +
            '        }' +
            '    ]' +
            '}]';
    
    	public static final String INVALID_MOCK_JSON_DATA = 
            '{' +
            '    "account": [' +
            '        {' +
            '            "firstName": "Clywd",' +
            '            "lastName": "Ilewicz",' +
            '            "company": "Shufflester",' +
            '            "status": "Closed - Converted"' +
            '        },' +
            '        {' +
            '            "firstName": "Quinn",' +
            '            "lastName": "Czapla",' +
            '            "company": "Edgeclub",' +
            '            "status": "Closed - Converted"' +
            '        },' +
            '        {' +
            '            "firstName": "Benedetta",' +
            '            "lastName": "Ames",' +
            '            "company": "Divavu",' +
            '            "status": "Closed - Not Converted"' +
            '        }' +
            '    ]' +
            '}';

}