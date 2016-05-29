#Thinginess
Thinginess does two things. First, it provides some ActiveRecord-style methods for filtering and updating collections of objects according to attributes. Second, it provides a mechanism for keeping track of sets of things according to their class hierarchy.

```ruby
class Tree < Thinginess::Thing
end

class Pine < Tree
end

class Birch < Tree
end

Pine.create(size: :small)
Pine.create(size: :medium)
Birch.create(size: :medium)
Tree.create(size: :massive)

Pine.count
# => 2
Birch.count
# => 1
Tree.count
# => 4

Tree.where(size: :medium).count
# => 2

Pine.update_all(size: :massive)

Tree.where(size: :medium).count
# => 1
```

## The Manipulable API
Thing classes, and Collection objects, are both Manipulable. This means they have the methods `#where(attributes)`, `#update_all(attributes)`, and `#all`. They also implement [Enumerable](http://ruby-doc.org/core-2.3.1/Enumerable.html). Also they have a `#changed` method that returns things that have undergone an update, and a `#reset_change_tracking` method that does what you'd expect on all their things.

## The Thingish API
Calling `.create(attributes)` on a Thing class or any subclass will add an instance of that class to a global thing register. The attributes will be available via the `#attributes` method, or via direct `#[]` and `#[]=` methods on the instance. Each instance also has a `#types` method that returns an array of all the Thingish classes that the instance inherits. It also has an `#update(attributes)` method for setting attributes, a `#changed?` property, and a `#reset_change_tracking` method.

## The root object

`Thinginess::Thing` will be the root ancestor in the thing hierarchy by default. If you want to create a different object you can simply include `Thinginess::Thingish`, e.g.

```ruby
class BaseObject < Some::Third::Party::Thing
  include Thinginess::Thingish
end
```

## Resetting the thing register
You can clear out the global thing register at any time by calling `Thinginess::Thing.clear_thing_register`

