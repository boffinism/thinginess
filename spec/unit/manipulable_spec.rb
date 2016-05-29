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

  describe '#each' do
    it 'iterates through the collection' do
      manipulable.each { |thing| thing.update(size: :large) }
      expect(manipulable.where(size: :large).count).to eq 3
    end
  end

  describe '#changed' do
    let(:first_thing) { double :thing, changed?: true }
    let(:second_thing) { double :thing, changed?: false }
    let(:things) { [first_thing, second_thing] }
    it 'returns a Collection' do
      expect(manipulable.changed).to be_a Thinginess::Collection
    end

    it 'returns only things that are changed' do
      expect(manipulable.changed.count).to eq 1
    end
  end

  describe '#reset_change_tracking' do
    let(:first_thing) { double :thing, reset_change_tracking: nil }
    let(:second_thing) { double :thing, reset_change_tracking: nil }
    let(:things) { [first_thing, second_thing] }

    it 'resets change tracking on things' do
      expect(first_thing).to receive :reset_change_tracking
      expect(second_thing).to receive :reset_change_tracking
      manipulable.reset_change_tracking
    end
  end

  describe '(Enumerable methods)' do
    [:all?,
     :any?,
     :count,
     :detect,
     :each_with_index,
     :find,
     :first,
     :include?,
     :inject,
     :map,
     :member?,
     :none?,
     :one?,
     :reduce,
     :reject,
     :select,
     :to_a].each do |enumerable_method|
      it { should respond_to enumerable_method }
    end
  end
end
