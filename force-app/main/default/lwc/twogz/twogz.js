import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getLayoutFullName from '@salesforce/apex/LayoutHelper.getLayoutFullName';
import ACCOUNT_NAME_FIELD from '@salesforce/schema/Account.Name';
export default class Twogz extends LightningElement {
    error;
    data;
    id;
    date;
    record;
    object;
    objectApiName;
    layout;
    layoutFullName;
    
    //Récupère le layout id au chargement du composant
    handleLoad(event) {
/*         console.log("detail", event.detail);
        console.log('Layout => ', event.detail.layouts);
        console.log('test',Object.keys(event.detail.layoutUserStates)[0]); */
        this.layout=Object.keys(event.detail.layoutUserStates)[0];
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
    @wire(getLayoutFullName, { layoutId: '$layout' })
    wiredLayout({ error, data }) {
        console.log('LayoutId', this.layout)
        console.log('LayoutFullName', data);
        if (data) {
            this.layoutFullName = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.layoutFullName = undefined;
        }
    }
}