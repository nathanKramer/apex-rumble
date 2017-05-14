/**
 * RumbleDB
 * Implements the standard Database class with Rumble objects
 * https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_methods_system_database.htm
 *
 * Some method signatures have changed due to reserved keywords.
 * As a general rule, we have suffixd `rows` to DML methods
 *
 * delete => deleteRows
 * insert => insertRows
 * update => updateRows
 * upsert => upsertRows
 * merge => mergeRows
 *
 * @author Nathan
 * @date 28th November 2016
 */
public with sharing class RumbleDB {

    //Deletes an existing sObject record, such as an individual account or contact, from your organization's data.
    public static Database.DeleteResult deleteRows(RumbleModel recordToDelete, Boolean allOrNone) {
        return Database.delete(recordToDelete.getSObject(), allOrNone);
    }

    //Deletes a list of existing sObject records, such as individual accounts or contacts, from your organization’s data.
    public static Database.DeleteResult[] deleteRows(List<RumbleModel> recordsToDelete, Boolean allOrNone) {
        return Database.delete(RumbleModel.getSObject(recordsToDelete), allOrNone);
    }

    //Deletes existing sObiect records, such as individual accounts or contacts, from your organization’s data.
    public static Database.DeleteResult deleteRows(Id recordID, Boolean allOrNone) {
        return Database.delete(recordID, allOrNone);
    }

    //Deletes a list of existing sObject records, such as individual accounts or contacts, from your organization’s data.
    public static Database.DeleteResult[] deleteRows(List<Id> recordIDs, Boolean allOrNone) {
        return Database.delete(recordIDs, allOrNone);
    }

    //Adds an sObject, such as an individual account or contact, to your organization's data.
    public static Database.SaveResult insertRows(RumbleModel recordToInsert, Boolean allOrNone) {
        return Database.insert(recordToInsert.getSObject(), allOrNone);
    }

    //Adds one or more sObjects, such as individual accounts or contacts, to your organization’s data.
    public static Database.SaveResult[] insertRows(List<RumbleModel> recordsToInsert, Boolean allOrNone) {
        return Database.insert(RumbleModel.getSObject(recordsToInsert), allOrNone);
    }

    //Adds an sObject, such as an individual account or contact, to your organization's data.
    public static Database.SaveResult insertRows(RumbleModel recordToInsert, Database.DMLOptions dmlOptions) {
        return Database.insert(recordToInsert.getSObject(), dmlOptions);
    }

    //Adds one or more sObjects, such as individual accounts or contacts, to your organization's data.
    public static Database.SaveResult[] insertRows(List<RumbleModel> recordsToInsert, Database.DMLOptions dmlOptions) {
        return Database.insert(RumbleModel.getSObject(recordsToInsert), dmlOptions);
    }

    //Merges the specified duplicate record into the master sObject record of the same type, deleting the duplicate, and reparenting any related records. Merges only accounts, contacts, or leads.
    public static Database.MergeResult mergeRows(RumbleModel masterRecord, Id duplicateId) {
        return Database.merge(masterRecord.getSObject(), duplicateId);
    }

    //Merges the specified duplicate sObject record into the master sObject of the same type, deleting the duplicate, and reparenting any related records.
    public static Database.MergeResult mergeRows(RumbleModel masterRecord, RumbleModel duplicateRecord) {
        return Database.merge(masterRecord.getSObject(), duplicateRecord.getSObject());
    }

    //Merges up to two records of the same sObject type into the master sObject record, deleting the others, and reparenting any related records.
    public static List<Database.MergeResult> mergeRows(RumbleModel masterRecord, List<Id> duplicateIds) {
        return Database.merge(masterRecord.getSObject(), duplicateIds);
    }

    //Merges up to two records of the same object type into the master sObject record, deleting the others, and reparenting any related records.
    public static List<Database.MergeResult> mergeRows(RumbleModel masterRecord, List<RumbleModel> duplicateRecords) {
        return Database.merge(masterRecord.getSObject(), RumbleModel.getSObject(duplicateRecords));
    }

    //Merges the specified duplicate record into the master sObject record of the same type, optionally returning errors, if any, deleting the duplicate, and reparenting any related records.
    // Merges only accounts, contacts, or leads.
    public static Database.MergeResult mergeRows(RumbleModel masterRecord, Id duplicateId, Boolean allOrNone) {
        return Database.merge(masterRecord.getSObject(), duplicateId, allOrNone);
    }

    //Merges the specified duplicate sObject record into the master sObject of the same type, optionally returning errors, if any, deleting the duplicate, and reparenting any related records.
    public static Database.MergeResult mergeRows(RumbleModel masterRecord, RumbleModel duplicateRecord, Boolean allOrNone) {
        return Database.merge(masterRecord.getSObject(), duplicateRecord.getSObject(), allOrNone);
    }

    //Merges up to two records of the same sObject type into the master sObject record, optionally returning errors, if any, deleting the duplicates, and reparenting any related records.
    public static List<Database.MergeResult> mergeRows(RumbleModel masterRecord, List<Id> duplicateIds, Boolean allOrNone) {
        return Database.merge(masterRecord.getSObject(), duplicateIds, allOrNone);
    }

    //Merges up to two records of the same object type into the master sObject record, optionally returning errors, if any, deleting the duplicates, and reparenting any related records.
    public static List<Database.MergeResult> mergeRows(RumbleModel masterRecord, List<RumbleModel> duplicateRecords, Boolean allOrNone) {
        return Database.merge(masterRecord.getSObject(), RumbleModel.getSObject(duplicateRecords), allOrNone);
    }

    //Modifies an existing sObject record, such as an individual account or contact, in your organization's data.
    public static Database.SaveResult updateRows(RumbleModel recordToUpdate, Boolean allOrNone) {
        return Database.update(recordToUpdate.getSObject(), allOrNone);
    }

    //Modifies one or more existing sObject records, such as individual accounts or contactsinvoice statements, in your organization’s data.
    public static Database.SaveResult[] updateRows(List<RumbleModel> recordsToUpdate, Boolean allOrNone) {
        return Database.update(RumbleModel.getSObject(recordsToUpdate), allOrNone);
    }

    //Modifies an existing sObject record, such as an individual account or contact, in your organization's data.
    public static Database.SaveResult updateRows(RumbleModel recordToUpdate, Database.DMLOptions dmlOptions) {
        return Database.update(recordToUpdate.getSObject(), dmlOptions);
    }

    //Modifies one or more existing sObject records, such as individual accounts or contactsinvoice statements, in your organization’s data.
    public static Database.SaveResult[] updateRows(List<RumbleModel> recordsToUpdate, Database.DMLOptions dmlOptions) {
        return Database.update(RumbleModel.getSObject(recordsToUpdate), dmlOptions);
    }

    //Creates a new sObject record or updates an existing sObject record within a single statement, using a specified field to determine the presence of existing objects, or the ID field if no field is specified.
    //public static Database.UpsertResult upsertRows(RumbleModel recordToUpsert, Schema.SObjectField externalIdField, Boolean allOrNone) {
    //    return Database.upsert(recordToUpsert.getSObject(), externalIdField, allOrNone);
    //}

    ////Creates new sObject records or updates existing sObject records within a single statement, using a specified field to determine the presence of existing objects, or the ID field if no field is specified.
    //public static Database.UpsertResult upsertRows(List<RumbleModel> recordsToUpsert, Schema.SObjectField externalIdField, Boolean allOrNone) {
    //    return Database.upsert(recordToUpsert.getSObject(), externalIdField, allOrNone);
    //}

}
