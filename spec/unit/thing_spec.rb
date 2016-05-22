require_relative '../../lib/thinginess'

RSpec.describe Thinginess::Thing do
  describe 'instance methods' do
    subject(:thing) { Thinginess::Thing.new }

    it { should respond_to :[] }
    it { should respond_to :[]= }
    it { should respond_to :attributes }
    it { should respond_to :types }
  end

  describe 'class methods' do
    subject(:thing) { Thinginess::Thing }
    let(:subclass) { Class.new(Thinginess::Thing) }

    it { should respond_to :create }
    it { should respond_to :where }
    it { should respond_to :update_all }
    it { should respond_to :all }
    it { should respond_to :to_a }
    it { should respond_to :count }

    describe '.clear_thing_register' do
      it 'gets rid of all things and subclass things' do
        thing.create
        subclass.create

        thing.clear_thing_register
        expect(thing.count).to eq 0
      end

      it 'raises an exception when called on a subclass' do
        expect { subclass.clear_thing_register }.to raise_error
      end
    end
  end
end
