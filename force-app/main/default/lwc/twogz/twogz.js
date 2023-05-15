import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import twogz from '@salesforce/resourceUrl/twogz';
import Id from '@salesforce/user/Id';
import getLayoutFullName from '@salesforce/apex/LayoutHelper.getLayoutFullName';
import insertInLog from '@salesforce/apex/LogHelper.insertInLog';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';

export default class Twogz extends LightningElement {
    error;
    user_Id;;
    layoutObject;
    layoutId;
    layoutFullName;
    twogzLogo = twogz;
    recordTest;
    
    handleLoad(event) {
        event.preventDefault();
        this.layoutId=Object.keys(event.detail.layoutUserStates)[0];
        this.layoutObject=Object.keys(event.detail.layouts)[0];
        this.user_Id = Id;
        this.invokeApexMethods();
    };

    async invokeApexMethods() {
        try {
            this.layoutFullName = await getLayoutFullName({layoutId: this.layoutId});
        } catch(error) {
            console.error(error);
        } finally {
            insertInLog({layoutFullName: this.layoutFullName, userId: this.user_Id, layoutObject: this.layoutObject})
            .then(result => {
                console.log('Insert in log success', result);
            })
            .catch(error => {
                console.error(error);
            });
            console.log('Done');
            console.log('Layout Id: ' + this.layoutId);
            console.log('Layout FullName: ' + this.layoutFullName);
        }
    }
    
    @api recordId;
    @api objectApiName;
    @wire(getRecord, { recordId: '$recordId', fields: [ACCOUNT_NAME_FIELD] })
    record
}