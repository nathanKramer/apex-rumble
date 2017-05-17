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
		set {
			this.put('Id', value);
		}
	}

	public String name {
		get {
			return (String) this.get('Name');
		}
		set {
			this.put('Name', value);
		}
	}

	public Object cause {
		get {
			return (Object) this.get('Cause__c');
		}
		set {
			this.put('Cause__c', value);
		}
	}

	public Object exception {
		get {
			return (Object) this.get('Exception__c');
		}
		set {
			this.put('Exception__c', value);
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

	public String message {
		get {
			return (String) this.get('Message__c');
		}
		set {
			this.put('Message__c', value);
		}
	}

	public DateTime occurrenceDate {
		get {
			return (DateTime) this.get('OccurrenceDate__c');
		}
		set {
			this.put('OccurrenceDate__c', value);
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

	public Object sandbox {
		get {
			return (Object) this.get('Sandbox__c');
		}
		set {
			this.put('Sandbox__c', value);
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

	public String userId {
		get {
			return (String) this.get('UserId__c');
		}
		set {
			this.put('UserId__c', value);
		}
	}

}
