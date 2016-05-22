require_relative '../../lib/thinginess.rb'

RSpec.describe 'Find, update and count' do
  let(:child_class) { Class.new(Thinginess::Thing) }

  before do
    Thinginess::Thing.clear_thing_register

    3.times { child_class.create matches: true }
    2.times { child_class.create matches: false }
  end

  example 'I find instances that match a property' do
    expect(child_class.where(matches: true).count).to eq 3
  end

  example 'I update instances to match a property' do
    child_class.where(matches: false).update_all(matches: true)

    expect(child_class.where(matches: true).count).to eq 5
  end

  example 'I find subclass instances by searching the superclass' do
    expect(Thinginess::Thing.where(matches: true).count).to eq 3
  end
end
