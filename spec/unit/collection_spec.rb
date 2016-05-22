require_relative '../../lib/thinginess'

RSpec.describe Thinginess::Collection do
  let(:initial_values) { :some_values }
  subject(:collection) { Thinginess::Collection.new initial_values }

  it { should respond_to :where }
  it { should respond_to :update_all }
  it { should respond_to :all }
  it { should respond_to :to_a }
  it { should respond_to :count }

  describe '#things' do
    it 'returns the initialized value' do
      expect(collection.things).to eq initial_values
    end
  end
end
