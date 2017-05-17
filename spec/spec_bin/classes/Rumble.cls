/**
 * Rumble.cls
 * Description:
 * Welcome to Rumble!
 * https://github.com/nathanKramer/apex-rumble
 * Apex Rumble is an abstraction between Salesforce's object schema and your Apex code.
 *
 * ## How Does It Work?
 *
 * ### RumbleModel
 *
 * The `RumbleModel` class serves as the base class for all RumbleModels, and it contains method signatures that redirect to the standard SObject method signatures.
 *
 * ```
 * RumbleModel
 * ├─ RumbleAccount (generated from Account)
 * │  └─ MAccount
 * ├─ RumbleAsset (generated from Asset)
 * |  └─ MAsset
 * ├─ RumbleContact (generated from Contact)
 * |  └─ MContact
 * └─ RumbleProject (generated from Project__c)
 * |  └─ MProject
 * ```
 *
 * ### RumbleModels
 *
 * e.g.
 * - `RumbleContact`
 * - `RumbleProject`
 * - `Rumble*`
 *
 * RumbleModels are a generated set of (virtual) model classes that are based off of your Salesforce schema: you configure an object and field subscription and your RumbleModels are generated off of that.
 *
 * Rumble models contain a class property for each subcribed SObject field, and employ apex's getter/setter syntax, redirecting property access to the private SObject managed my the `RumbleModel` base class.
 *
 * By using RumbleModels, your apex code does not need to explicitly reference your Salesforce Schema by API name, which empowers developers to refactor their Salesforce schema.
 *
 * ### Models
 *
 * e.g.
 * - `MContact`
 * - `MProject`
 * - `M*`
 *
 * RumbleModels are volatile - meaning that they are intended to be regenerated over and over as your schema changes.
 *
 * For this reason, we don't recommend your write any of your own code in RumbleModel classes.
 *
 * Instead, for every RumbleModel subclass that you get, you get a corresponding extension of that class to use for your own logic and customisations. Once these classes exist, Rumble won't touch them again.
 *
 */
public with sharing class Rumble {
	// Rumble wide exceptions
	public class InvalidObjectException extends Exception {}

	// NOT the object subscription. This is the global object description map, present for convenience
	public static Map<String, Schema.SObjectType> OBJECTS = Schema.getGlobalDescribe();

	// For the sake of experiment, let's say the field subscription is generated as a map here for apex access
	public static final Map<String, List<String>> FIELD_SUBSCRIPTION = new Map<String, List<String>> {
		'Exception__c' => new List<String> {
			'Id',
			'Name',
			'Account__c',
			'Context__c',
			'Label__c',
			'Notes__c',
			'UniqueName__c'
		},
		'Occurrence__c' => new List<String> {
			'Id',
			'Name',
			'JobId__c',
			'Message__c',
			'OccurrenceDate__c',
			'OrganizationId__c',
			'Stacktrace__c',
			'UserId__c'
		}
	};
}
