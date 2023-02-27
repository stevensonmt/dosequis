# Entity Component System

```elixir

DosEquis.Registry.start

# Create an entity with a given collection of components.
bunny = DosEquis.Entity.build([TimeComponent.new(%{age: 0})])

# Each game turn, we may trigger a system to process and push some state updates to our components.
TimeSystem.process
TimeSystem.process

# Because Elixir is immutable, we need to pull the latest state.
bunny = DosEquis.Entity.reload(bunny)

# New components can be added at runtime, adding new behaviour to existing entities.
bunny = DosEquis.Entity.add(bunny, TimeComponent.new(%{age: 10}))

# State updates will also be pushed to components added at runtime.
TimeSystem.process
bunny = DosEquis.Entity.reload(bunny)

```

## Thanks

This was forked from the wonderfully illustrative [ECS](http://github.com/yosriady/ecs/) library authored by [yos.io](http://yos.io) on GitHub [@yosriady](https://github.com/yosriady). Released under the [MIT license](http://mit-license.org/).
