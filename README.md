# Apex Rumble

Apex Rumble is an abstraction between Salesforce's object schema and your Apex code.

## How Does It Work?

<aspirational>
### RumbleModel

The `RumbleModel` class serves as the base class for all RumbleModels, and it contains method signatures that redirect to the standard SObject method signatures.

```
RumbleModel
├─ RumbleAccount (generated from Account)
│  └─ MAccount
├─ RumbleAsset (generated from Asset)
|  └─ MAsset
├─ RumbleContact (generated from Contact)
|  └─ MContact
└─ RumbleProject (generated from Project__c)
|  └─ MProject
```

### RumbleModels

e.g.
- `RumbleContact`
- `RumbleProject`
- `Rumble*`

RumbleModels are a generated set of (virtual) model classes that are based off of your Salesforce schema: you configure an object and field subscription and your RumbleModels are generated off of that.

Rumble models contain a class property for each subcribed SObject field, and employ apex's getter/setter syntax, redirecting property access to the private SObject managed my the `RumbleModel` base class.

By using RumbleModels, your apex code does not need to explicitly reference your Salesforce Schema by API name, which empowers developers to refactor their Salesforce schema.

### Models

e.g.
- `MContact`
- `MProject`
- `M*`

RumbleModels are volatile - meaning that they are intended to be regenerated over and over as your schema changes.

For this reason, we don't recommend your write any of your own code in RumbleModel classes.

Instead, for every RumbleModel subclass that you get, you get a corresponding extension of that class to use for your own logic and customisations. Once these classes exist, Rumble won't touch them again.
</aspirational>
