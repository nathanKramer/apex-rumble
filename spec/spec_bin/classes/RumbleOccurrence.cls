/**
 * RumbleOccurrence.cls
 * Description: Base Model object for Occurrence__c
 *
 * Rumble* base model classes are primarily boilerplate, intended to be generated from your schema and then extended with a custom class.
 *
 * Warning! This is a generated class! Modifications may be overwritten by further regeneration of this class!
 * @author: Apex Rumble
 */
public virtual with sharing class RumbleOccurrence extends RumbleModel {

	public RumbleOccurrence() {
		super('Occurrence__c');
	}

	public RumbleOccurrence(SObject record) {
		super(record);
		RumbleModel.validate(record, 'Occurrence__c');
	}

	// Fields as properties

	public Id id {
		get {
			return (Id) this.get('Id');
		}
		private set;
	}

	public Boolean isDeleted {
		get {
			return (Boolean) this.get('IsDeleted');
		}
		private set;
	}

	public String name {
		get {
			return (String) this.get('Name');
		}
		private set;
	}

	public Datetime createdDate {
		get {
			return (Datetime) this.get('CreatedDate');
		}
		private set;
	}

	public Id createdById {
		get {
			return (Id) this.get('CreatedById');
		}
		private set;
	}

	public Datetime lastModifiedDate {
		get {
			return (Datetime) this.get('LastModifiedDate');
		}
		private set;
	}

	public Id lastModifiedById {
		get {
			return (Id) this.get('LastModifiedById');
		}
		private set;
	}

	public Datetime systemModstamp {
		get {
			return (Datetime) this.get('SystemModstamp');
		}
		private set;
	}

	public Id exception {
		get {
			return (Id) this.get('Exception__c');
		}
		private set;
	}

	public Datetime occurrenceDate {
		get {
			return (Datetime) this.get('OccurrenceDate__c');
		}
		set {
			this.put('OccurrenceDate__c', value);
		}
	}

	public String userId {
		get {
			return (String) this.get('UserId__c');
		}
		set {
			this.put('UserId__c', value);
		}
	}

	public String organizationId {
		get {
			return (String) this.get('OrganizationId__c');
		}
		set {
			this.put('OrganizationId__c', value);
		}
	}

	public String message {
		get {
			return (String) this.get('Message__c');
		}
		set {
			this.put('Message__c', value);
		}
	}

	public String stacktrace {
		get {
			return (String) this.get('Stacktrace__c');
		}
		set {
			this.put('Stacktrace__c', value);
		}
	}

	public String cause {
		get {
			return (String) this.get('Cause__c');
		}
		set {
			this.put('Cause__c', value);
		}
	}

	public Boolean sandbox {
		get {
			return (Boolean) this.get('Sandbox__c');
		}
		set {
			this.put('Sandbox__c', value);
		}
	}

	public String jobId {
		get {
			return (String) this.get('JobId__c');
		}
		set {
			this.put('JobId__c', value);
		}
	}

}
