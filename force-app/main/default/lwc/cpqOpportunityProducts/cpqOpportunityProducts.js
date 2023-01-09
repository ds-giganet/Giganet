import { LightningElement, api,track, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { deleteRecord } from "lightning/uiRecordApi";
import { getRelatedListRecords } from 'lightning/uiRelatedListApi';
export default class cpqOpportunityProducts extends NavigationMixin(LightningElement) {
    @api recordId;             // 
    @track rows;               // 
    @track isLoading;          // 
    @track product;            // 
    @track productDeleteModal; // 
    @track products;           // 
    @track rows;               // 
    @track rowsFilter;         // 
    @track rowsNumberPerPage;  // 
    connectedCallback() {
        this.isLoading = true;
    }
    @wire(getRelatedListRecords, {
        parentRecordId: '$recordId',
        relatedListId: 'Opportunity_Products__r',
        fields: [
            'Product__c.Id','Product__c.Name','Product__c.Parent__c','Product__c.Product__c','Product__c.Icon__c',
            'Product__c.Supplier__c','Product__c.Supplier_Name__c','Product__c.Location__c','Product__c.Location_Name__c',
            'Product__c.Install_Amount__c', 'Product__c.Install_GP__c','Product__c.Monthly_GP__c','Product__c.Monthly_Revenue__c',
            'Product__c.Quantity__c','Product__c.Term__c','Product__c.Type__c','Product__c.Family__c',
        ]
    })
    getProducts({data, error}) {
        if(data) {
            this.products = data.records;
            this.getRows();
        }
        if(error) {
            this.error = error;
    }   }
    getRows() {
        this.isLoading = true;
        // console.log('products');
        // console.log(this.products);
        // this.rows = { parent: '', childrens : [] };
        //
        if(this.rowsFilter === 'Connectivity') {

        }
        else if(this.rowsFilter === 'Equipment') {

        }
        else if(this.rowsFilter === 'Licence') {

        }
        else if(this.rowsFilter === 'Location') {

        }
        else if(this.rowsFilter === 'Supplier') {

        }
        else {
            this.rows = this.products;
            for(var row in this.products) {
                // this.rows.push(row);
                // console.log('row');
                // console.log(row);
            }
        }
        // console.log('rows');
        // console.log(row);
        this.isLoading = false;   
    }
    get hasRows() {
        if(this.products && this.products.length > 0) {
            return true;
        }
        else {
            return false;
    }   }
    addProduct() {
        //event.preventDefault();
        //event.stopPropagation();
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                "objectApiName": "Product__c",
                "actionName": "new",
            },
        });
    }
    deleteProduct() {
        deleteRecord(this.product.fields.Id.value)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Record deleted',
                    variant: 'success'
                })
            );
        })
        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error deleting record',
                    message: error.body.message,
                    variant: 'warning'
                })
            );
        });
        this.closeProductModal();
    }
    editProduct(event) {
        //event.preventDefault();
        //event.stopPropagation();
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                "recordId": event.target.value,
                "objectApiName": "Product__c",
                "actionName": "edit",
            },
        });
    }
    viewProduct(event) {
        //event.preventDefault();
        //event.stopPropagation();
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                "recordId": event.target.value,
                "objectApiName": "Product2",
                "actionName": "view"
            },
        });
    }
    viewAccount(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                "recordId": event.target.value,
                "objectApiName": "Account",
                "actionName": "view"
            },
        });
    }
    viewLocation(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                "recordId": event.target.value,
                "objectApiName": "Location__c",
                "actionName": "view"
            },
        });
    }
    closeProductModal() {
        this.product            = null;
        this.productDeleteModal = false;
    }
    showProductDeleteModal(event) {
        this.product            = event.target.value;
        this.productDeleteModal = true;
}   }