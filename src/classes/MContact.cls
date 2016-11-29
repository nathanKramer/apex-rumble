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
    // Generate static selector methods here?
    public MContact(Contact c) {
        super(c);
    }

    // For the sake of experiment, let's say there are generated selector methods here
    // The SOQL would be generated using the same "field subscription" concept as the models themselves (field subscription might be driven by a metadata API query that can then be filtered down?)
    // It should be very easy to write new selectors. Abstract away the field subscription such that developers need only write query filters
    private static final List<String> FIELD_NAME_SUBSCRIPTION = new List<String> {
        'Id',
        'FirstName',
        'LastName',
        'Email',
        'ExampleCustomField__c'
    };

    public static List<MContact> getById(Set<Id> contactIds) {
        String queryString = 'SELECT ' +
            String.join(FIELD_NAME_SUBSCRIPTION, ',') +
            ' FROM Contact WHERE Id IN :contactIds';
        System.debug(queryString);

        List<Contact> contacts = Database.query(
            queryString
        );
        List<MContact> mContacts = new List<MContact>();
        for (Contact c : contacts) {
            mContacts.add(new MContact(c));
        }
        return mContacts;
    }

    public static MContact getById(Id contactId) {
        return getById(new Set<Id> { contactId })[0];
    }
}
