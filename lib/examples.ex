defmodule DosEquis.Examples do 
  @moduledoc "Should be loaded in dev for access to provided examples."


  use Application

  def start(_type, _args) do
    children = [DosEquis.Registry]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
