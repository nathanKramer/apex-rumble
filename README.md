# ApexRumble

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
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'apex_rumble'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install apex_rumble

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/apex_rumble. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

