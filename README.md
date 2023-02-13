About this fork:
=================
I created this fork to update the ratev4 interface to be more closely aligned with the specifications provided by the usps. Machinable is a required field and takes a boolean value as is an ID for each package which can take an int or a string. Support for multiple packages are also now supported and can be passed to the gem as an array of hashes of the same format as before. 

##Usage:
```
packages = [
    {
        :id => 0,
        :service => "ONLINE",
        :zip_origination => "12345",
        :zip_destination => 67890,
        :container => '',
        :width => 1,
        :length => 2,
        :height => 3,
        :value => 34,
        :pounds => 67,
        :ounces => 3,
        :machinable => true
    },
    {
        :id => 1,
        :service => "ONLINE",
        :zip_origination => "12345",
        :zip_destination => 67890,
        :container => '',
        :width => 12,
        :length => 54,
        :height => 234,
        :value => 123,
        :pounds => 78,
        :ounces => 234,
        :machinable => true
    }
]

usps = Usps::Client.new({
    user_id: Rails.application.credentials.usps[:username]
})
                    
rates = usps.rate_v4({
    :rate_v4_request => {
        :revision => 2,
        :packages => packages
    }
})
```
USPS Ruby Client
=================
[![Build Status](https://travis-ci.com/joeyparis/usps-ruby-client.svg?branch=master)](https://travis-ci.com/joeyparis/usps-ruby-client)
[![Maintainability](https://api.codeclimate.com/v1/badges/29579702db626edc43ab/maintainability)](https://codeclimate.com/github/joeyparis/usps-ruby-client/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/29579702db626edc43ab/test_coverage)](https://codeclimate.com/github/joeyparis/usps-ruby-client/test_coverage)

An unofficial Ruby client for The United Sates Postal Service Web Tools API.

**Disclaimer** This gem is mostly auto-generated from the [USPS API User Guides](https://www.usps.com/business/web-tools-apis/documentation-updates.htm). Because of inconsistencies and inaccuracies in the user guides, some endpoints may not work as expected or may not be consistent with other methods in this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'usps-ruby-client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install usps-ruby-client

## Usage

```
client = Usps::Client.new({
    user_id: ENV['USPS_USER_ID'] # The user_id will default to `ENV['USPS_USER_ID']` so this is technically unnecessary.
})

client.city_state_lookup({
    city_state_lookup_request: {
        zip_code: {
            zip5: 33626
        }
    }
})


# Returns
{
    "CityStateLookupResponse" => {
        "ZipCode"=>{
            "City"=>"TAMPA",
            "State"=>"FL",
            "Zip5"=>"33626"
        }
    }
}
```

## RubyDoc Automatic Documentation
The generator also creates [documentation](https://rubydoc.info/gems/usps-ruby-client) to help you navigate the available methods. It has the same issues presented in the disclaimer above.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Updating the auto-generated methods

Because the USPS website does not allow scripts to make requests against their website, you must [download the API User Guide HTML files manually](https://www.usps.com/business/web-tools-apis/documentation-updates.htm). I recommend right-clicking the **HTM** and selecting *Save Link As...* to prevent any browser extensions from injecting their code and breaking the parsing.

Place just the `.htm` files in `lib/data/api` (and remove any that may no longer be active) and run `rake usps:api:update`. This task will recreate all the appropriate methods and some basic spec tests.

We might be able to automate this with a headless browser tool like Watir, but only if we can do that in a way that doesn't bloat the gem as a whole.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/joeyparis/usps-ruby-client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/joeyparis/usps-ruby-client/blob/master/CODE_OF_CONDUCT.md).

This project is still an early work-in-progress, so any additional help is greatly appreciated!

## License

The gem is available as open-source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Usps project's codebases, issue trackers, chat rooms, and mailing lists is expected to follow the [code of conduct](https://github.com/joeyparis/usps-ruby-client/blob/master/CODE_OF_CONDUCT.md).
