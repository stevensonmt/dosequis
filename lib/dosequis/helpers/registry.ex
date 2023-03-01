defmodule DosEquis.Registry do
  @moduledoc """
    Component registry. Used by systems to locate components of its type.

    iex> {:ok, r} = DosEquis.Registry.start
    iex> DosEquis.Registry.insert("test", r)
    :ok
    iex> DosEquis.Registry.get("test")
    [#PID<0.87.0>]
  """

  use Agent

  def start_link(_), do: start()

  def start do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def insert(component_type, component_pid) do
    Agent.update(__MODULE__, fn registry ->
      components = Map.get(registry, component_type, []) ++ [component_pid]
      Map.put(registry, component_type, components)
    end)
  end

  def get(component_type) do
    Agent.get(__MODULE__, fn registry ->
      Map.get(registry, component_type, [])
    end)
  end
end
