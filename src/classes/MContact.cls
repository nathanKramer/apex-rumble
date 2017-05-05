/**
 * MContact.cls
 * Description: The class that you would customize
 * The M prefeix is obviously kinda ugly,
 * The intention is that, without being able to structure code in folders, we at least want models to be in the same place.
 * The Rumble prefix is dispatched with because Rumble files will largely be generated base classes that shouldn't be messed with
 * @author: Nathan
 * @date: 28th November
 */
public with sharing class MContact extends RumbleContact {

    public MContact() {
        super();
    }

    public MContact(SObject c) {
        super(c);
    }

    public static List<MContact> decorate(List<SObject> contacts) {
        List<MContact> mContacts = new List<MContact>();
        for (SObject c : contacts) {
            mContacts.add(new MContact(c));
        }
        return mContacts;
    }

    public static RumbleQuery find() {
        return new RumbleQuery().find('Contact');
    }

    // --------------
    // Select Methods
    // --------------

    public static List<MContact> getById(Set<Id> contactIds) {
        List<SObject> records = Database.query(
            MContact.find()
                .filterBy('Id IN :contactIds')
                .toSOQL()
        );
        return decorate(records);
    }

    public static MContact getById(Id contactId) {
        return getById(new Set<Id> { contactId })[0];
    }

    public static List<MContact> getByEmail(String email) {
        MContact example = new MContact();
        example.email = email;

        List<SObject> records = Database.query(
            new RumbleQuery()
                .filterBy(example)
                .toSOQL()
        );
        return decorate(records);
    }

    // --------------
    // Domain Methods
    // --------------
}
