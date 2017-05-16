/**
 * MOccurrence.cls
 * Description: Model object and database interaction layer for Occurrence__c
 * @author: Apex Rumble
 * @date: 28th November
 */
public with sharing class MOccurrence extends RumbleOccurrence {

	public MOccurrence() {
		super();
	}

	public MOccurrence(SObject record) {
		super(record);
	}

	public static List<MOccurrence> decorate(List<SObject> records) {
		List<MOccurrence> mOccurrences = new List<MOccurrence>();
		for (SObject record : records) {
			mOccurrences.add(new MOccurrence(record));
		}
		return mOccurrences;
	}

	public static RumbleQuery find() {
		return new RumbleQuery().find('Occurrence__c');
	}

	// --------------
	// Select Methods
	// --------------

	public static List<MOccurrence> getById(Set<Id> recordIds) {
		List<SObject> records = Database.query(
			MOccurrence.find()
				.filterBy('Id IN :recordIds')
				.toSOQL()
		);
		return decorate(records);
	}

	public static MOccurrence getById(Id recordId) {
		return getById(new Set<Id> { recordId })[0];
	}

	// --------------
	// Domain Methods
	// --------------
}
