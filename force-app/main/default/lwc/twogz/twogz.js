import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import Id from '@salesforce/user/Id';
import getLayoutFullName from '@salesforce/apex/LayoutHelper.getLayoutFullName';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class Twogz extends LightningElement {
    error;
    data;
    userId;
    date;
    record;
    object;
    objectApiName;
    layoutId;
    layoutFullName;

    
    handleLoad(event) {
        event.preventDefault();
        console.log(event.detail, 'event');
        this.layoutId=Object.keys(event.detail.layoutUserStates)[0];
        this.userId = Id;
        this.object=Object.keys(event.detail.layouts)[0];
       getLayoutFullName({layoutId: this.layoutId})
        .then(result => 
          {this.layoutFullName = result
            this.error = undefined}) 
        .catch (error => {this.error = error
            this.layoutFullName = undefined})
        .finally(() => {console.log(this.layoutFullName, 'layoutFullName')});
      /*   console.log(this.layoutFullName, 'layoutFullName');
        console.log(this.error, 'error');  */
        console.log(this.userId, 'id');
        console.log(this.object , 'object');
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



    /*      @wire(getLayoutFullName, { layoutId: '$layoutId' })
    wiredLayout({ error, data }) {
        console.log('LayoutId', this.layoutId)
        console.log('LayoutFullName', data);
        if (data) {
            this.layoutFullName = data;
            this.error = undefined;

        } else if (error) {
            this.error = error;
            this.layoutFullName = error;
        }
    }   */

}