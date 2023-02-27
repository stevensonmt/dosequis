defmodule DosEquis.System do
  @moduledoc """
    A base for creating new Systems.
  """
  @type action :: (... -> any) | atom | String.t() | [action]
  @callback dispatch(component_id :: any, action :: action) :: any
  @callback components() :: Enumerable.t()
  @callback process(components :: Enumerable.t(), action :: action) :: Enumerable.t()
end
