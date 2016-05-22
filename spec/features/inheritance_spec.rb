require_relative '../../lib/thinginess.rb'

RSpec.describe 'Inheritance' do
  let(:child_class) { Class.new(Thinginess::Thing) }
  let(:sibling_class) { Class.new(Thinginess::Thing) }
  let(:grandchild_class) { Class.new(child_class) }

  before { Thinginess::Thing.clear_thing_register }

  example 'I create a child class object' do
    child_class.create

    expect(Thinginess::Thing.count).to eq 1
    expect(child_class.count).to eq 1
    expect(sibling_class.count).to eq 0
    expect(grandchild_class.count).to eq 0
  end

  example 'I create a child and a sibling' do
    child_class.create
    sibling_class.create

    expect(Thinginess::Thing.count).to eq 2
    expect(child_class.count).to eq 1
    expect(sibling_class.count).to eq 1
    expect(grandchild_class.count).to eq 0
  end

  example 'I create a child, sibling and grandchild' do
    child_class.create
    sibling_class.create
    grandchild_class.create

    expect(Thinginess::Thing.count).to eq 3
    expect(child_class.count).to eq 2
    expect(sibling_class.count).to eq 1
    expect(grandchild_class.count).to eq 1
  end
end
