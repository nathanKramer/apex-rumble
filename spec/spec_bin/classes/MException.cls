/**
 * MException.cls
 * Description: Model object and database interaction layer for Exception__c
 * @author: Apex Rumble
 * @date: 28th November
 */
public with sharing class MException extends RumbleException {

	public MException() {
		super();
	}

	public MException(SObject record) {
		super(record);
	}

	public static List<MException> decorate(List<SObject> records) {
		List<MException> mExceptions = new List<MException>();
		for (SObject record : records) {
			mExceptions.add(new MException(record));
		}
		return mExceptions;
	}

	public static RumbleQuery find() {
		return new RumbleQuery().find('Exception__c');
	}

	// --------------
	// Select Methods
	// --------------

	public static List<MException> getById(Set<Id> recordIds) {
		List<SObject> records = Database.query(
			MException.find()
				.filterBy('Id IN :recordIds')
				.toSOQL()
		);
		return decorate(records);
	}

	public static MException getById(Id recordId) {
		return getById(new Set<Id> { recordId })[0];
	}

	// --------------
	// Domain Methods
	// --------------
}
