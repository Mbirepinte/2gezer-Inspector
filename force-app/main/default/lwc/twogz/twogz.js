import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import getLayoutFullName from '@salesforce/apex/LayoutHelper.getLayoutFullName';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class Twogz extends LightningElement {
    error;
    user_Id;;
    layoutObject;
    layoutId;
    layoutFullName;

    
    handleLoad(event) {
        event.preventDefault();
        /* console.log(event.detail, 'event');
        console.log(Object.keys(event.detail.layouts)[0], 'layouts'); */
        this.layoutId=Object.keys(event.detail.layoutUserStates)[0];
        this.layoutObject=Object.keys(event.detail.layouts)[0];
        this.user_Id = Id;
        getLayoutFullName({layoutId: this.layoutId,userId: this.user_Id, object_c: this.layoutObject})
            .then(result => { 
                this.layoutFullName = result
                this.error = undefined
            .catch (error => {
                this.error = error
                this.layoutFullName = undefined})
            .finally(() => {console.log(result, 'result')})
            })   
    };
    
    
    @api recordId;
    @api objectApiName;
    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD] })
    record
}