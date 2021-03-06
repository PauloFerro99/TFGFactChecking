defmodule IgeSup do
  @moduledoc """
  Documentation for `IgeSup`.
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
        start: {Ige, :new, []}
      }
    ]

    Supervisor.init(child, strategy: :one_for_one)
  end
end
