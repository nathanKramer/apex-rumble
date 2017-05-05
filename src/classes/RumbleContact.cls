/**
 * RumbleContact.cls
 * Description: An example of base SObject model
 * Ideally this would be generated using a `field subscription` concept which would drive the class properties generated and the dynamic SOQL generated
 * @author: Nathan
 * @date: 28th November 2016
 */
public virtual with sharing class RumbleContact extends RumbleModel {

    public RumbleContact() {
        super('Contact');
    }

    public RumbleContact(SObject record) {
        super(record);
        RumbleModel.validate(record, 'Contact');
    }

    // Below I have implemented a few fields to illustrate the concept

    public String id {
        get {
            return (String) this.get('Id');
        }
        set {
            this.put('Id', value);
        }
    }

    public String firstName {
        get {
            return (String) this.get('FirstName');
        }
        set {
            this.put('FirstName', value);
        }
    }

    public String lastName {
        get {
            return (String) this.get('LastName');
        }
        set {
            this.put('LastName', value);
        }
    }

    public String email {
        get {
            return (String) this.get('Email');
        }
        set {
            this.put('Email', value);
        }
    }

    // An example custom field
    public String exampleCustomField {
        get {
            return (String) this.get('ExampleCustomField__c');
        }
        set {
            this.put('ExampleCustomField__c', value);
        }
    }
}
