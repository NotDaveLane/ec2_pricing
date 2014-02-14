require 'test/unit'
require 'ec2_pricing'

class PricingTest < Test::Unit::TestCase
  def test_on_demand_instances_exist_with_hourly_costs
    on_demand_instances = Ec2Pricing::Instances.on_demand

    assert_not_nil on_demand_instances['us-east']['m3.xlarge']['hourly']
    assert_not_nil on_demand_instances['us-west-2']['m3.medium']['hourly']

    hourly_cost = on_demand_instances['us-west-2']['m3.medium']['hourly']
    assert_equal hourly_cost.to_f, hourly_cost.to_f.to_s.to_f, 'hourly_cost #{hourly_cost} is not a float value.'

    puts "Favorite Hourly: $#{'%.3f' % on_demand_instances['us-east']['m1.medium']['hourly']}"
  end

  def test_reserved_instances_exist_with_upfront_and_hourly_costs
    reserved_instances = Ec2Pricing::Instances.reserved

    assert_not_nil reserved_instances['us-east']['m3.xlarge']['1yr']['upfront']
    assert_not_nil reserved_instances['us-east']['m3.xlarge']['1yr']['hourly']
    assert_not_nil reserved_instances['us-west-1']['m3.2xlarge']['1yr']['upfront']
    assert_not_nil reserved_instances['us-west-1']['m3.2xlarge']['1yr']['hourly']

    upfront_cost = reserved_instances['us-west-1']['m3.2xlarge']['1yr']['upfront']
    assert_equal upfront_cost.to_i, upfront_cost.to_i.to_s.to_i, 'upfront_cost #{upfront_cost} is not an integer value.'

    puts "Favorite Upfront: $#{'%.2f' % reserved_instances['us-east']['m1.medium']['1yr']['upfront']}"
    puts "Favorite Hourly: $#{'%.3f' % reserved_instances['us-east']['m1.medium']['1yr']['hourly']}"
  end
end