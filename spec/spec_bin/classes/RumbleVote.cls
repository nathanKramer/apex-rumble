/**
 * RumbleVote.cls
 * Description: Base Model object for Vote
 *
 * Rumble* base model classes are primarily boilerplate, intended to be generated from your schema and then extended with a custom class.
 *
 * Warning! This is a generated class! Modifications may be overwritten by further regeneration of this class!
 * @author: Apex Rumble
 */
public virtual with sharing class RumbleVote extends RumbleModel {

	public RumbleVote() {
		super('Vote');
	}

	public RumbleVote(SObject record) {
		super(record);
		RumbleModel.validate(record, 'Vote');
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

	public Id parentId {
		get {
			return (Id) this.get('ParentId');
		}
		private set;
	}

	public String type {
		get {
			return (String) this.get('Type');
		}
		set {
			this.put('Type', value);
		}
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

}
