/**
 * RumbleException.cls
 * Description: Base Model object for Exception__c
 *
 * Rumble* base model classes are primarily boilerplate, intended to be generated from your schema and then extended with a custom class.
 *
 * Warning! This is a generated class! Modifications may be overwritten by further regeneration of this class!
 * @author: Apex Rumble
 */
public virtual with sharing class RumbleException extends RumbleModel {

	public RumbleException() {
		super('Exception__c');
	}

	public RumbleException(SObject record) {
		super(record);
		RumbleModel.validate(record, 'Exception__c');
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

	public Id account {
		get {
			return (Id) this.get('Account__c');
		}
		set {
			this.put('Account__c', value);
		}
	}

	public String context {
		get {
			return (String) this.get('Context__c');
		}
		set {
			this.put('Context__c', value);
		}
	}

	public String label {
		get {
			return (String) this.get('Label__c');
		}
		set {
			this.put('Label__c', value);
		}
	}

	public String notes {
		get {
			return (String) this.get('Notes__c');
		}
		set {
			this.put('Notes__c', value);
		}
	}

	public Decimal occurrences {
		get {
			return (Decimal) this.get('Occurrences__c');
		}
		private set;
	}

	public String uniqueName {
		get {
			return (String) this.get('UniqueName__c');
		}
		set {
			this.put('UniqueName__c', value);
		}
	}

	public DateTime mostRecentOccurrenceDate {
		get {
			return (DateTime) this.get('MostRecentOccurrenceDate__c');
		}
		private set;
	}

}
