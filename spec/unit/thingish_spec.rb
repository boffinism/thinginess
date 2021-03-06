require_relative '../../lib/thinginess'

RSpec.describe Thinginess::Thingish do
  let(:thingish_class) do
    Class.new do
      include Thinginess::Thingish
    end
  end

  let(:subclass) { Class.new(thingish_class) }
  let(:sibling_class) { Class.new(thingish_class) }
  let(:args) { { args: :args } }

  subject(:thing) { thingish_class.create args }

  before { Thinginess::Thing.clear_thing_register }

  describe '.create' do
    it 'assigns args as attributes' do
      expect(thing.attributes).to eq args
    end

    it "sets #types to an array containing the Thingish thing's class" do
      expect(thing.types).to eq [thingish_class]
    end

    context '(when subclassing a Thingish class)' do
      subject(:thing) { subclass.create args }

      it 'sets #types to an array containing the parent class as well' do
        expect(thing.types).to eq [subclass, thingish_class]
      end

      it 'makes the thing available via the subclass manipulable methods' do
        thing
        expect(subclass.to_a).to eq [thing]
      end

      it 'makes the thing available via the parent class manipulable methods' do
        thing
        expect(thingish_class.to_a).to eq [thing]
      end

      it 'does not make the thing available via sibling class manipulable methods' do
        thing
        expect(sibling_class.to_a).to eq []
      end
    end

    it 'makes the thing available via its own manipulable methods' do
      thing
      expect(thingish_class.to_a).to eq [thing]
    end

    it 'does not make the thing available via subclass manipulable methods' do
      thing
      expect(subclass.to_a).to eq []
    end
  end

  describe '.clear_thing_register' do
    before do
      thingish_class.create
      subclass.create
      sibling_class.create
    end

    it 'gets rid of all things' do
      thingish_class.clear_thing_register
      expect(thingish_class.count).to eq 0
    end

    it 'gets rid of subclass things' do
      thingish_class.clear_thing_register
      expect(subclass.count).to eq 0
    end

    it 'gets rid of all parent class things' do
      subclass.clear_thing_register
      expect(thingish_class.count).to eq 0
    end

    it 'gets rid of all parent class things' do
      subclass.clear_thing_register
      expect(sibling_class.count).to eq 0
    end
  end

  describe '#[]' do
    it 'delegates to the attributes array' do
      thing.attributes[:colour] = :blue

      expect(thing[:colour]).to eq :blue
    end
  end

  describe '#[]=' do
    it 'delegates to the attributes array' do
      thing[:colour] = :blue

      expect(thing.attributes[:colour]).to eq :blue
    end
  end

  describe '#update' do
    it 'batch assigns attributes' do
      thing.update(colour: :red, size: :large)
      expect(thing[:colour]).to eq :red
      expect(thing[:size]).to eq :large
    end
  end

  describe '#changed?' do
    it 'returns false initially' do
      expect(thing.changed?).to eq false
    end

    it 'returns true after an update that changes a property' do
      thing.update(new: :property)
      expect(thing.changed?).to eq true
    end

    it 'returns false after an update that changes nothing' do
      thing.update(args)
      expect(thing.changed?).to eq false
    end
  end

  describe '#reset_change_tracking' do
    it 'resets changed? to false' do
      thing.update(new: :property)
      thing.reset_change_tracking
      expect(thing.changed?).to eq false
    end
  end
end
