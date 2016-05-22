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
  end
end
