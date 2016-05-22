module Thinginess
  class Thing
    include Thingish

    def self.clear_thing_register
      if parent_is_a_thing?
        raise 'For clarity you really should only call this method on Thingishness::Thing'
      else
        @thing_register = []
      end
    end
  end
end
