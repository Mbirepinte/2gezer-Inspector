import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACCOUNT_RECORD_TYPE_ID_FIELD from '@salesforce/schema/Account.RecordTypeId';
export default class Twogz extends LightningElement {
    error;
    data;
    id;
    date;
    hour;
    record;
    object;

    @api recordId;

    @api objectApiName;
    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD] })
    wiredRecord({ error, data }) {
        console.log('data', data);
        if (data) {
            this.data = data;
            this.error = undefined;
            this.date=data.lastModifiedDate;
            this.id=data.id;
            this.object=data.apiName;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
    }
 
}