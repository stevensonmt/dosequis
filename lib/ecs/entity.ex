defmodule ECS.Entity do
  @moduledoc """
    A behaviour for creating new Entities.
  """

  @type entity :: pid | integer | Collectable.t()

  @callback init(components :: [any]) :: Collectable.t()

  @callback add(entity :: entity, components :: [any]) :: entity

  @callback reload(entity :: entity) :: entity

  defmacro __using__(_options) do
    quote do
      # Require Components to implement interface
      @behaviour ECS.Entity
    end
  end
end
