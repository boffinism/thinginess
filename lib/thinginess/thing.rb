module Thing
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    include Manipulable

    def create(attributes = {})
      thing = self.new
      thing.attributes = attributes
      thing.types = gather_types
      add_to_thing_register(thing)
      thing
    end

    private

    def gather_types(current_class=self, types=[])
      if current_class == Object
        types
      else
        types << current_class
        gather_types current_class.superclass, types
      end
    end

    def thing_register
      if parent_is_a_thing?
        superclass.thing_register
      else
        @thing_register
      end
    end

    def clear_thing_register
      if parent_is_a_thing?
        superclass.clear_thing_register
      else
        @thing_register = []
      end
    end

    def add_to_thing_register(value)
      if parent_is_a_thing?
        superclass.add_to_thing_register value
      else
        @thing_register ||= []
        @thing_register << value
      end
    end

    def parent_is_a_thing?
      superclass.respond_to? :thinginess
    end

    def thinginess
      true
    end

    def things
      thing_register.select { |entry| entry.types.include? self }
    end
  end

  
  attr_accessor :attributes
  attr_accessor :types
end
