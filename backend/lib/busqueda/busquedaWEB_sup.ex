defmodule BusquedaWEBSup do
  @moduledoc """
  Documentation for `BusquedaWEBSup`.
  """

  use Supervisor

  # Public API

  def new() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  # Callbacks

  def init([]) do
    child = [
      %{
        id: Backend,
        start: {BusquedaWEB, :new, []}
      }
    ]

    Supervisor.init(child, strategy: :one_for_one)
  end
end
