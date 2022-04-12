defmodule BusquedaPDFSup do
  @moduledoc """
  Documentation for `BusquedaPDFSup`.
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
        start: {BusquedaPDF, :new, []}
      }
    ]

    Supervisor.init(child, strategy: :one_for_one)
  end
end
