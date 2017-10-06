/**
 * MVote.cls
 * Description: Model object and database interaction layer for Vote
 * @author: Apex Rumble
 * @date: 28th November
 */
public with sharing class MVote extends RumbleVote {

	public MVote() {
		super();
	}

	public MVote(SObject record) {
		super(record);
	}

	public static List<MVote> decorate(List<SObject> records) {
		List<MVote> mVotes = new List<MVote>();
		for (SObject record : records) {
			mVotes.add(new MVote(record));
		}
		return mVotes;
	}

	public static RumbleQuery find() {
		return new RumbleQuery().find('Vote');
	}

	// --------------
	// Select Methods
	// --------------

	public static List<MVote> getById(Set<Id> recordIds) {
		List<SObject> records = Database.query(
			MVote.find()
				.filterBy('Id IN :recordIds')
				.toSOQL()
		);
		return decorate(records);
	}

	public static MVote getById(Id recordId) {
		return getById(new Set<Id> { recordId })[0];
	}

	// --------------
	// Domain Methods
	// --------------
}
