defmodule DosEquis.Component do
  @moduledoc """
    A base for creating new Components.
  """

  defstruct [:id, :state]

  @type id :: pid()
  @type component_type :: String.t()
  @type state :: map()
  @type t :: %DosEquis.Component{
          # Component Agent ID
          id: id,
          state: state
        }

  # Component interface
  @callback new(state) :: t
  @callback get(id) :: t
  @callback update(id, state) :: t

  defmacro __using__(_options) do
    quote do
      # Require Components to implement interface
      @behaviour DosEquis.Component
    end
  end

  @doc "Create a new agent to keep the state"
  @spec new(component_type, state) :: t
  def new(component_type, initial_state) do
    {:ok, pid} = DosEquis.Component.Agent.start_link(initial_state)
    # Register component for systems to reference
    DosEquis.Registry.insert(component_type, pid)

    %__MODULE__{
      id: pid,
      state: initial_state
    }
  end

  @doc "Retrieves state"
  @spec get(id) :: t
  def get(pid) do
    state = DosEquis.Component.Agent.get(pid)

    %__MODULE__{
      id: pid,
      state: state
    }
  end

  @doc "Updates state"
  @spec update(id, state) :: t
  def update(pid, new_state) do
    DosEquis.Component.Agent.set(pid, new_state)

    %__MODULE__{
      id: pid,
      state: new_state
    }
  end
end
