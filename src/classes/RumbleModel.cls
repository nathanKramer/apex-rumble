/**
 * RumbleModel
 * Description:
 * @author: Nathan
 * @date: 29 November 2016
 */
public virtual with sharing class RumbleModel {
    private SObject record;

    public RumbleModel(Schema.SObjectType objectType) {
        this.record = objectType.newSObject();
    }

    public RumbleModel(String objectType) {
        this(Rumble.OBJECTS.get(objectType));
    }

    public RumbleModel(SObject sObj) {
        this.record = sObj;
    }

    public static void validate(SObject record, String expectedType) {
        // Used internally by rumble so that validation is done in one place.
        String actualType = record.getSObjectType().getDescribe().getName();
        if (record.getSObjectType().getDescribe().getName() != expectedType) {
            throw new Rumble.InvalidObjectException(
                'Tried to create a Rumble ' + 
                expectedType + 
                ', but got given a ' +
                actualType
            );
        }
    }

    /**
     * Return the SObject this RumbleModel is decorating
     * NB: Use sparingly.
     * Ideally you would only need to call this method when calling standard apex methods that require SObjects.
     * @author Nathan
     * @return SObject the sObject being decorated
     */
    public SObject getSObject() {
        return this.record;
    }

    /**
     * Get a list of SObjects from a list of RumbleModels
     * NB: Use sparingly.
     * Ideally you would only need to call this method when calling standard apex methods that require SObjects.
     * @author Nathan
     * @param List<RumbleModel> models : the models you need SObjects for
     * @return List<SObject> the list of sobjects
     */
    public static List<SObject> getSObject(List<RumbleModel> models) {
        List<SObject> sObjects = new List<SObject>();
        for (RumbleModel model : models) {
            sObjects.add(model.getSObject());
        }
        return sObjects;
    }

    //----------------------------
    // SObject redirection methods
    //----------------------------

    /**
     * Marks a record with a custom error message and prevents any DML operation from occurring.
     */
    public void addError(String errorMsg) {
        this.record.addError(errorMsg);
    }

    /**
     * Marks a record with a custom error message, specifies whether or not the error message should be escaped, and prevents any DML operation from occurring.
     */
    public void addError(String errorMsg, Boolean escape) {
        this.record.addError(errorMsg, escape);
    }

    /**
     * Marks a record with a custom error message and prevents any DML operation from occurring.
     */
    public void addError(Exception exceptionError) {
        this.record.addError(exceptionError);
    }

    /**
     * Marks a record with a custom exception error message, specifies whether or not the exception error message should be escaped, and prevents any DML operation from occurring.
     */
    public void addError(Exception exceptionError, Boolean escape) {
        this.record.addError(exceptionError, escape);
    }

    /**
     * Clears all field values
     */
    public void clear() {
        this.record.clear();
    }

    /**
     * Creates a copy of the rumble model
     */
    public RumbleModel clone(Boolean preserveId, Boolean isDeepClone, Boolean preserveReadonlyTimestamps, Boolean preserveAutonumber) {
        return new RumbleModel(
            this.record.clone(
                preserveId,
                isDeepClone,
                preserveReadonlyTimestamps,
                preserveAutonumber
            )
        );
    }

    /**
    * Returns the value for the field specified by fieldName, such as AccountNumber.
    */
    public Object get(String fieldName) {
        return this.record.get(fieldName);
    }

    /**
    * Returns the value for the field specified by the field token Schema.sObjectField, such as, Schema.Account.AccountNumber.
    */
    public Object get(Schema.sObjectField field) {
        return this.record.get(field);
    }

    /**
    * Returns the ID of the entity from which an object was cloned. You can use it for objects cloned through the Salesforce user interface.
    * If you don’t use a preserveId parameter, of if you use a preserveId value of false, you can also used it for objects created using the System.SObject.clone(preserveId, isDeepClone, preserveReadonlyTimestamps, preserveAutonumber) method.
    */
    public Id getCloneSourceId() {
        return this.record.getCloneSourceId();
    }

    /**
    * Returns the database.DMLOptions object for the sObject.
    */
    public Database.DMLOptions getOptions() {
        return this.record.getOptions();
    }

    /**
    * Returns a map of populated field names and their corresponding values. The map contains only the fields that have been populated in memory for the SObject instance.
    */
    public Map<String,Object> getPopulatedFieldsAsMap() {
        return this.record.getPopulatedFieldsAsMap();
    }

    // /**
    // * Returns the value for the specified field. This method is primarily used with dynamic DML to access values for external IDs.
    // */
    // public void getSObject(fieldName) {
    //     this.record.getSObject();
    // }

    // /**
    // * Returns the value for the field specified by the field token Schema.fieldName, such as, Schema.MyObj.MyExternalId. This method is primarily used with dynamic DML to access values for external IDs.
    // */
    // public void getSObject(fieldName) {
    //     this.record.getSObject();
    // }

    // /**
    // * Returns the values for the specified field. This method is primarily used with dynamic DML to access values for associated objects, such as child relationships.
    // */
    // public void getSObjects(fieldName) {
    //     this.record.getSObjects();
    // }

    // /**
    // * Returns the value for the field specified by the field token Schema.fieldName, such as, Schema.Account.Contact. This method is primarily used with dynamic DML to access values for associated objects, such as child relationships.
    // */
    // public void getSObjects(fieldName) {
    //     this.record.getSObjects();
    // }

    /**
    * Returns the token for this sObject. This method is primarily used with describe information.
    */
    public Schema.SObjectType getSObjectType() {
        return this.record.getSObjectType();
    }

    /**
    * Retrieves the name of a quick action associated with this sObject. Typically used in triggers.
    */
    public String getQuickActionName() {
        return this.record.getQuickActionName();
    }

    /**
    * Returns true if an entity is cloned from something, even if the entity hasn’t been saved.
    */
    public Boolean isClone() {
        return this.record.isClone();
    }

    /**
    * Sets the value for the specified field and returns the previous value for the field.
    */
    public Object put(String fieldName, Object value) {
        return this.record.put(fieldName, value);
    }

    /**
    * Sets the value for the field specified by the field token Schema.sObjectField, such as, Schema.Account.AccountNumber and returns the previous value for the field.
    */
    public void put(Schema.SObjectField fieldName, Object value) {
        this.record.put(fieldName, value);
    }

    // /**
    // * Sets the value for the specified field. This method is primarily used with dynamic DML for setting external IDs. The method returns the previous value of the field.
    // */
    // public void putSObject(fieldName, value) {
    //     this.record.putSObject();
    // }

    // /**
    // * Sets the value for the field specified by the token Schema.sObjectType. This method is primarily used with dynamic DML for setting external IDs. The method returns the previous value of the field.
    // */
    // public void putSObject(fieldName, value) {
    //     this.record.putSObject();
    // }

    /**
    * Recalculates all formula fields on an sObject, and sets updated field values. Rather than inserting or updating objects each time you want to test changes to your formula logic, call this method and inspect your new field values. Then make further logic changes as needed.
    */
    public void recalculateFormulas() {
        this.record.recalculateFormulas();
    }

    /**
    * Sets the DMLOptions object for the sObject.
    */
    public void setOptions(Database.DMLOptions options) {
        this.record.setOptions(options);
    }
}
