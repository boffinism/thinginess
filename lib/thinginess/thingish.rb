module Thinginess
  module Thingish
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      include Manipulable

      def create(attributes = {})
        thing = new
        thing.attributes = attributes
        thing.types = gather_types
        thing_register << thing
        thing
      end

      def clear_thing_register
        do_in_root_thing :clear_thing_register do
          @thing_register = []
        end
      end

      protected

      def thinginess
        true
      end

      def thing_register
        do_in_root_thing :thing_register do
          @thing_register ||= []
        end
      end

      private

      def gather_types(current_class = self, types = [])
        if current_class == Object
          types
        else
          types << current_class
          gather_types current_class.superclass, types
        end
      end

      def do_in_root_thing(method_name)
        if parent_is_a_thing?
          superclass.send method_name
        else
          yield
        end
      end

      def parent_is_a_thing?
        superclass.respond_to? :thinginess, true
      end

      def things
        thing_register.select { |entry| entry.types.include? self }
      end
    end

    attr_accessor :attributes
    attr_accessor :types

    def [](key)
      attributes[key]
    end

    def []=(key, value)
      attributes[key] = value
    end
  end
end
