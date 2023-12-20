import { LightningElement, api, track } from 'lwc';
import { subscribe, unsubscribe, onError, setDebugFlag, isEmpEnabled } from 'lightning/empApi';
import handleJSONFile from '@salesforce/apex/CreateRecordsFromJSONController.handleJSONFile';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateRecordsFromJSON extends LightningElement {
    status = 'Wait for the file'; 
    recordsCreated = 0;
    recordsFailed = 0;
    totalRecordsAmount = 0;

    subscription = {};
    @api channelName = '/event/Record_Created__e';

    acceptedFormats = ['.json'];

    connectedCallback() {
        this.registerErrorListener();
        this.handleSubscribe();
    }

    handleUploadFile(event) {
        if (event.detail.files && event.detail.files.length) {
            this.status = 'Processing...';
            const jsonFile = event.detail.files[0];
            const fileReader = new FileReader();
            fileReader.onloadend = () => {
                const jsonObject = fileReader.result;
                const apexParams = {
                    JSONdata: jsonObject.toString()
                };
                handleJSONFile(apexParams)
                    .then(() => {
                        this.ShowToast('File was uploaded successfully!', 
                                        'Check process info under button!', 
                                        'success', 
                                        'dismissable'
                        );
                    })
                    .catch((error) => {
                        this.ShowToast('Something went wrong...', 
                                        'Please contact to your administrator', 
                                        'error', 
                                        'dismissable'
                        );
                    });
            };
            fileReader.readAsText(jsonFile);
        }
    }

    handleSubscribe() {
        const self = this;
        const messageCallback = function (response) {
            var obj = JSON.parse(JSON.stringify(response));
            let objData = obj.data.payload;
            self.status = objData.Status__c;
            self.recordsCreated = objData.Records_created__c;
            self.recordsFailed = objData.Records_Failed__c;
            self.totalRecordsAmount = objData.Total_Records_Amount__c;

            if(self.status === 'Error') {
                self.ShowToast('Something went wrong...', 
                                        'Please contact to your administrator', 
                                        'error', 
                                        'dismissable'
                );
            } else {
                self.ShowToast('Records created successfully!', 
                            'Now you can check your records', 
                            'success', 
                            'dismissable'
                );
            }
        };
 
        subscribe(this.channelName, -1, messageCallback)
            .then(response => {
                this.subscription = response;
            });
    }

    registerErrorListener() {
        onError(error => {
            console.log('Received error: ', JSON.stringify(error));
        });
    }

    ShowToast(title, message, variant, mode) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
    }
}