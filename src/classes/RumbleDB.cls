/**
 * RumbleDB
 * Implements the standard Database class with Rumble objects
 * https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_database.htm
 * Some method signatures have changed due to reserved keywords:
 *
 * delete => drop
 * insert => create
 * update => save
 * upsert => createOrSave
 * merge => mergeRecords
 *
 * @author Nathan
 * @date 28th November 2016
 */
public with sharing class RumbleDB {

    //Deletes an existing sObject record, such as an individual account or contact, from your organization's data.
    public static Database.DeleteResult drop(RumbleModel recordToDelete, Boolean allOrNone) {
        return Database.delete(recordToDelete.toSObject(), allOrNone);
    }

    //Deletes a list of existing sObject records, such as individual accounts or contacts, from your organization’s data.
    public static Database.DeleteResult[] drop(List<RumbleModel> recordsToDelete, Boolean allOrNone) {
        return Database.delete(RumbleModel.toSObject(recordsToDelete), allOrNone);
    }

    //Deletes existing sObiect records, such as individual accounts or contacts, from your organization’s data.
    public static Database.DeleteResult drop(Id recordID, Boolean allOrNone) {
        return Database.delete(recordID, allOrNone);
    }

    //Deletes a list of existing sObject records, such as individual accounts or contacts, from your organization’s data.
    public static Database.DeleteResult[] drop(List<Id> recordIDs, Boolean allOrNone) {
        return Database.delete(recordIDs, allOrNone);
    }

    //Adds an sObject, such as an individual account or contact, to your organization's data.
    public static Database.SaveResult create(RumbleModel recordToInsert, Boolean allOrNone) {
        return Database.insert(recordToInsert.toSObject(), allOrNone);
    }

    //Adds one or more sObjects, such as individual accounts or contacts, to your organization’s data.
    public static Database.SaveResult[] create(List<RumbleModel> recordsToInsert, Boolean allOrNone) {
        return Database.insert(RumbleModel.toSObject(recordsToInsert), allOrNone);
    }

    //Adds an sObject, such as an individual account or contact, to your organization's data.
    public static Database.SaveResult create(RumbleModel recordToInsert, Database.DMLOptions dmlOptions) {
        return Database.insert(recordToInsert.toSObject(), dmlOptions);
    }

    //Adds one or more sObjects, such as individual accounts or contacts, to your organization's data.
    public static Database.SaveResult[] create(List<RumbleModel> recordsToInsert, Database.DMLOptions dmlOptions) {
        return Database.insert(RumbleModel.toSObject(recordsToInsert), dmlOptions);
    }

    //Merges the specified duplicate record into the master sObject record of the same type, deleting the duplicate, and reparenting any related records. Merges only accounts, contacts, or leads.
    public static Database.MergeResult mergeRecords(RumbleModel masterRecord, Id duplicateId) {
        return Database.merge(masterRecord.toSObject(), duplicateId);
    }

    //Merges the specified duplicate sObject record into the master sObject of the same type, deleting the duplicate, and reparenting any related records.
    public static Database.MergeResult mergeRecords(RumbleModel masterRecord, RumbleModel duplicateRecord) {
        return Database.merge(masterRecord.toSObject(), duplicateRecord.toSObject());
    }

    //Merges up to two records of the same sObject type into the master sObject record, deleting the others, and reparenting any related records.
    public static List<Database.MergeResult> mergeRecords(RumbleModel masterRecord, List<Id> duplicateIds) {
        return Database.merge(masterRecord.toSObject(), duplicateIds);
    }

    //Merges up to two records of the same object type into the master sObject record, deleting the others, and reparenting any related records.
    public static List<Database.MergeResult> mergeRecords(RumbleModel masterRecord, List<RumbleModel> duplicateRecords) {
        return Database.merge(masterRecord.toSObject(), RumbleModel.toSObject(duplicateRecords));
    }

    //Merges the specified duplicate record into the master sObject record of the same type, optionally returning errors, if any, deleting the duplicate, and reparenting any related records.
    // Merges only accounts, contacts, or leads.
    public static Database.MergeResult mergeRecords(RumbleModel masterRecord, Id duplicateId, Boolean allOrNone) {
        return Database.merge(masterRecord.toSObject(), duplicateId, allOrNone);
    }

    //Merges the specified duplicate sObject record into the master sObject of the same type, optionally returning errors, if any, deleting the duplicate, and reparenting any related records.
    public static Database.MergeResult mergeRecords(RumbleModel masterRecord, RumbleModel duplicateRecord, Boolean allOrNone) {
        return Database.merge(masterRecord.toSObject(), duplicateRecord.toSObject(), allOrNone);
    }

    //Merges up to two records of the same sObject type into the master sObject record, optionally returning errors, if any, deleting the duplicates, and reparenting any related records.
    public static List<Database.MergeResult> mergeRecords(RumbleModel masterRecord, List<Id> duplicateIds, Boolean allOrNone) {
        return Database.merge(masterRecord.toSObject(), duplicateIds, allOrNone);
    }

    //Merges up to two records of the same object type into the master sObject record, optionally returning errors, if any, deleting the duplicates, and reparenting any related records.
    public static List<Database.MergeResult> mergeRecords(RumbleModel masterRecord, List<RumbleModel> duplicateRecords, Boolean allOrNone) {
        return Database.merge(masterRecord.toSObject(), RumbleModel.toSObject(duplicateRecords), allOrNone);
    }

    //Modifies an existing sObject record, such as an individual account or contact, in your organization's data.
    public static Database.SaveResult save(RumbleModel recordToUpdate, Boolean allOrNone) {
        return Database.update(recordToUpdate.toSObject(), allOrNone);
    }

    //Modifies one or more existing sObject records, such as individual accounts or contactsinvoice statements, in your organization’s data.
    public static Database.SaveResult[] save(List<RumbleModel> recordsToUpdate, Boolean allOrNone) {
        return Database.update(RumbleModel.toSObject(recordsToUpdate), allOrNone);
    }

    //Modifies an existing sObject record, such as an individual account or contact, in your organization's data.
    public static Database.SaveResult save(RumbleModel recordToUpdate, Database.DMLOptions dmlOptions) {
        return Database.update(recordToUpdate.toSObject(), dmlOptions);
    }

    //Modifies one or more existing sObject records, such as individual accounts or contactsinvoice statements, in your organization’s data.
    public static Database.SaveResult[] save(List<RumbleModel> recordsToUpdate, Database.DMLOptions dmlOptions) {
        return Database.update(RumbleModel.toSObject(recordsToUpdate), dmlOptions);
    }

    //Creates a new sObject record or updates an existing sObject record within a single statement, using a specified field to determine the presence of existing objects, or the ID field if no field is specified.
    //public static Database.UpsertResult createOrSave(RumbleModel recordToUpsert, Schema.SObjectField externalIdField, Boolean allOrNone) {
    //    return Database.upsert(recordToUpsert.toSObject(), externalIdField, allOrNone);
    //}

    ////Creates new sObject records or updates existing sObject records within a single statement, using a specified field to determine the presence of existing objects, or the ID field if no field is specified.
    //public static Database.UpsertResult createOrSave(List<RumbleModel> recordsToUpsert, Schema.SObjectField externalIdField, Boolean allOrNone) {
    //    return Database.upsert(recordToUpsert.toSObject(), externalIdField, allOrNone);
    //}

}
