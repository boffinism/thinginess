module Manipulable
  def where(desired_attributes = {})
    matching_things  = things.select do |thing|
      matches = true
      desired_attributes.each do |k, v|
        matches = false unless thing.attributes[k] == v
      end
      matches
    end

    Collection.new(matching_things)
  end

  def update_all(new_attributes = {})
    things.each do |thing|
      new_attributes.each do |k, v|
        thing.attributes[k] = v
      end
    end

    self
  end

  def all
    Collection.new(things)
  end

  def to_a
    things
  end

  def count
    things.length
  end

  def things
    raise NotImplementedError, "Anything that includes Manipulable must implement things"
  end
end