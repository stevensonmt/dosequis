# A bunny prefab
defmodule Bunny do
  use DosEquis.Entity

  defstruct [:id, :components]

  @type id :: String.t()
  @type components :: list(DosEquis.Component)
  @type t :: %__MODULE__{
          id: String.t(),
          components: components
        }

  @doc "Creates a new entity"
  @impl true
  def init(components) do
    %__MODULE__{
      id: DosEquis.Crypto.random_string(64),
      components: components
    }
  end

  @doc "Add components at runtime"
  @impl true
  def add(%__MODULE__{id: id, components: components}, new_components \\ []) do
    %__MODULE__{
      id: id,
      components: components ++ new_components
    }
  end

  @doc "Pulls the latest component states"
  @impl true
  def reload(%__MODULE__{id: _id, components: components} = entity) do
    updated_components =
      components
      |> Enum.map(fn %{id: pid} ->
        DosEquis.Component.get(pid)
      end)

    %{entity | components: updated_components}
  end
end
