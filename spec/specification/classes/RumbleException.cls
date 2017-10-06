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
		private set;
	}

	public Id ownerId {
		get {
			return (Id) this.get('OwnerId');
		}
		set {
			this.put('OwnerId', value);
		}
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

	public Id account {
		get {
			return (Id) this.get('Account__c');
		}
		set {
			this.put('Account__c', value);
		}
	}

	public Textarea context {
		get {
			return (Textarea) this.get('Context__c');
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

	public String uniqueName {
		get {
			return (String) this.get('UniqueName__c');
		}
		set {
			this.put('UniqueName__c', value);
		}
	}

	public Datetime mostRecentOccurrenceDate {
		get {
			return (Datetime) this.get('MostRecentOccurrenceDate__c');
		}
		private set;
	}

	public Double occurrences {
		get {
			return (Double) this.get('Occurrences__c');
		}
		private set;
	}

	public Textarea notes {
		get {
			return (Textarea) this.get('Notes__c');
		}
		set {
			this.put('Notes__c', value);
		}
	}

}
