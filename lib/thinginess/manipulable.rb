module Thinginess
  module Manipulable
    include Enumerable

    def each(&block)
      things.each(&block)
    end

    def where(desired_attributes = {})
      matching_things = things.select do |thing|
        !desired_attributes.any? do |k, v|
          thing[k] != v
        end
      end

      Collection.new(matching_things)
    end

    def update_all(new_attributes = {})
      things.each do |thing|
        thing.update(new_attributes)
      end

      self
    end

    def all
      Collection.new(things)
    end

    def changed
      Collection.new(things.select(&:changed?))
    end

    def reset_change_tracking
      things.each(&:reset_change_tracking)
    end

    private

    def things
      raise NotImplementedError, 'Anything that includes Manipulable must implement things'
    end
  end
end
