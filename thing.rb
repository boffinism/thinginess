module Thing
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def create(attributes = {})
      thing = self.new
      thing.assign_attributes(attributes)
      types = set_types
      add_to_thing_register({ types: types, thing: thing })
      thing
    end

    def set_types(current_class=self, types=[])
      if current_class == Object
        types
      else
        types << current_class
        set_types current_class.superclass, types
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

    def all
      thing_register.select do |entry|
        entry[:types].include? self
      end.map do |entry|
        entry [:thing]
      end
      #TODO: Return these wrapped in a Thinginess::Collection class
      #that includes th Thinginess::Manipulable module
    end

    def where(desired_attributes = {})
      #TODO: Move these out to a Thinginess::Manipulable module
    end

    def update_all(new_attributes = {})
      #TODO: Move these out to a Thinginess::Manipulable module
    end
  end

  def assign_attributes(attributes={})
    @attributes = attributes
  end
end

class BaseThing
  include Thing
end

class Tree < BaseThing
end
