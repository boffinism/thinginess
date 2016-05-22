require_relative '../../lib/thinginess'

RSpec.describe Thinginess::Manipulable do
  let(:manipulable_class) do
    Class.new do
      include Thinginess::Manipulable
      def initialize(things)
        @things = things
      end
      attr_reader :things
    end
  end

  let(:things) do
    [
      { colour: :blue },
      { colour: :blue },
      { colour: :red }
    ]
  end

  subject(:manipulable) { manipulable_class.new things }

  describe '#where' do
    it 'returns all in a new Collection if no arguments passed in' do
      resp = manipulable.where
      expect(resp).to be_a Thinginess::Collection
      expect(resp.things).to eq things
    end

    it 'returns only things that match given attributes' do
      resp = manipulable.where(colour: :blue)
      expect(resp.things.count).to eq 2
    end

    it 'returns an empty Collection if nothing matches' do
      resp = manipulable.where(colour: :green)
      expect(resp).to be_a Thinginess::Collection
      expect(resp.things.count).to eq 0
    end
  end

  describe '#update_all' do
    it 'sets the properties of all its objects as per args' do
      resp = manipulable.update_all(colour: :yellow)
      expect(resp).to eq manipulable
      resp.things.each do |thing|
        expect(thing[:colour]).to eq :yellow
      end
    end

    it 'can set previously undefined properties' do
      resp = manipulable.update_all(size: :large)
      expect(resp).to eq manipulable
      resp.things.each do |thing|
        expect(thing[:size]).to eq :large
      end
    end
  end

  describe '#all' do
    it 'returns a new Collection' do
      expect(manipulable.all).to be_a Thinginess::Collection
    end

    it 'provides all the things' do
      expect(manipulable.all.things).to eq things
    end
  end

  describe '#count' do
    it 'returns the number of things' do
      expect(manipulable.count).to eq 3
    end
  end

  describe '#to_a' do
    it 'returns the things' do
      expect(manipulable.to_a).to eq things
    end
  end
end
