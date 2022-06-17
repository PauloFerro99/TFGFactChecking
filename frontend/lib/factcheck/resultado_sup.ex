defmodule ResultadoSup do
  @moduledoc """
  Documentation for `ResultadoSup`.
  """

  use Supervisor

  # Public API

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  # Callbacks

  def init([]) do
    child = [
      %{
        id: Factcheck,
        start: {Resultado, :new, []}
      }
    ]

    Supervisor.init(child, strategy: :one_for_one)
  end
end
