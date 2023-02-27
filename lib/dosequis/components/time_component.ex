defmodule TimeComponent do
  @moduledoc """
    A component for keeping an age for something.

    {id: pid, state: state} = TimeComponent.new(%{age: 1})
  """
  use DosEquis.Component

  @component_type __MODULE__

  @doc "Initializes and validates state"
  def new(%{age: _age} = initial_state) do
    DosEquis.Component.new(@component_type, initial_state)
  end
end
