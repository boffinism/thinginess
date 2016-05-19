class Collection
  include Manipulable

  def initialize(things)
    @things = things
  end

  attr_reader :things
end