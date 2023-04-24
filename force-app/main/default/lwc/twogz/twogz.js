import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import getLayoutFullName from '@salesforce/apex/LayoutHelper.getLayoutFullName';
import insertInLog from '@salesforce/apex/LogHelper.insertInLog';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class Twogz extends LightningElement {
    error;
    data;
    user_Id;
    date;
    record;
    layoutObject;
    objectApiName;
    layoutId;
    layoutFullName;

    
    handleLoad(event) {
        event.preventDefault();
        console.log(event.detail, 'event');
        this.layoutId=Object.keys(event.detail.layoutUserStates)[0];
        this.user_Id = Id;
        this.layoutObject=Object.keys(event.detail.layouts)[0];
       getLayoutFullName({layoutId: this.layoutId,userId: this.user_Id, object_c: this.layoutObject})
            .then(result => { 
                this.layoutFullName = result
                this.error = undefined
            .catch (error => {
                this.error = error
                this.layoutFullName = undefined})
                .finally(() => {console.log(this.layoutFullName, 'layoutFullName')});
                console.log(this.user_Id, 'id');
                console.log(this.layoutObject , 'object');
            }) 
    };
    
    @api recordId;
    @api objectApiName;
    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD] })
    wiredRecord({ error, data }) {
        console.log('data', data);
        if (data) {
            this.data = data;
            this.fields= data.fields.name;
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