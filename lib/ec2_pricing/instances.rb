require 'json'
require 'open-uri'

module Ec2Pricing
  class Instances

    def self.on_demand
      instances('http://aws-assets-pricing-prod.s3.amazonaws.com/pricing/ec2/linux-od.js')
    end

    def self.reserved
      instances('http://aws-assets-pricing-prod.s3.amazonaws.com/pricing/ec2/linux-ri-heavy.js')
    end


    private

    def self.instances(callback_url)
      json = URI.parse(callback_url).read
      json = json.sub('callback(', '').sub(')', '')
      hash = JSON.parse(json)

      instances = {}
      for region in hash['config']['regions']
        region_name = region['region']
        instances[region_name] ||= {}

        for instanceType in region['instanceTypes']

          for size in instanceType['sizes']
            instance_size = size['size']
            instances[region_name][instance_size] ||= {}

            for valueColumn in size['valueColumns']
              # on-demand pricing has valueColumn names of 'linux' instead of a term length.
              if valueColumn['name'] == 'linux'
                instances[region_name][instance_size]['hourly'] = valueColumn['prices']['USD']
                next
              end

              # change 'yrTerm1' to '1yr'
              term = valueColumn['name'].sub('yrTerm', '') + 'yr'
              price = valueColumn['prices']['USD']
              rate = 'upfront'

              # after the above name change, change 'yrTerm1Hourly to '1yr'
              if term.include?('Hourly') || valueColumn['rate'].equal?('perhr')
                term = term.sub('Hourly', '')
                rate = 'hourly'
              end

              instances[region_name][instance_size][term] ||= {}
              instances[region_name][instance_size][term][rate] = price
            end
          end
        end
      end
      instances
    end
  end
end