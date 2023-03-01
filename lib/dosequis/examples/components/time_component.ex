defmodule TimeComponent do
  @moduledoc """
    A component for keeping an age for something.

    {id: pid, state: state} = TimeComponent.new(%{age: 1})
  """
  use DosEquis.Component

  @component_type __MODULE__ |> to_string()

  @doc "Initializes and validates state"
  @spec new(DosEquis.Component.state()) :: DosEquis.Component.t()
  @impl true
  def new(%{age: _age} = initial_state) do
    {:ok, pid} = DosEquis.Component.Agent.start_link(initial_state)
    # Register component for systems to reference 
    DosEquis.Registry.insert(@component_type, pid)
    %DosEquis.Component{id: pid, state: initial_state}
  end

  @doc "Retrieves state"
  @spec get(DosEquis.Component.id()) :: DosEquis.Component.t()
  @impl true
  def get(id) do
    state = DosEquis.Component.Agent.get(id)
    %DosEquis.Component{id: id, state: state}
  end

  @doc "Updates state and returns new state"
  @spec update(DosEquis.Component.id(), DosEquis.Component.state()) :: DosEquis.Component.t()
  @impl true
  def update(id, new_state) do
    DosEquis.Component.Agent.set(id, new_state)
    %DosEquis.Component{id: id, state: new_state}
  end
end
