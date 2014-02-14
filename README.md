# ec2_pricing

This gem provides a simple way to retrieve upfront and hourly costs for Amazon EC2 On Demand and Reserved Instances.

## Installation

Add this line to your application's Gemfile:

    gem 'ec2_pricing'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ec2_pricing

## Usage

For either type of instance, simply specify the region, instance type, and price type you'd like to see.

### On Demand Pricing
    instances = Ec2Pricing::Instances.on_demand
    instances['us-east']['m3.medium']['hourly']  # hourly cost for an m3.medium On Demand Instance in US-East

### Reserved Instance Pricing
    instances = Ec2Pricing::Instances.reserved
    instances['us-east']['m3.medium']['1yr']['upfront']  # upfront cost with a 1-year commitment
    instances['us-east']['m3.medium']['1yr']['hourly']   # hourly cost with a 1-year commitment

## Contributing

1. Fork it ( https://github.com/NotDaveLane/ec2_pricing/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
