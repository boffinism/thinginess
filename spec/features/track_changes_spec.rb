require_relative '../../lib/thinginess.rb'

RSpec.describe 'Track changes' do
  let(:child_class) { Class.new(Thinginess::Thing) }

  before do
    Thinginess::Thing.clear_thing_register
  end

  example 'I track changes' do
    2.times { child_class.create }
    child_class.first.update(foo: :bar)

    expect(child_class.first).to be_changed
    expect(child_class.changed.count).to eq 1

    child_class.reset_change_tracking

    expect(child_class.first).not_to be_changed
    expect(child_class.changed.count).to eq 0
  end
end
