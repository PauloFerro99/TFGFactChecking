defmodule BusquedaPDF do
  @moduledoc """
  Documentation for `BusquedaPDF`.
  """

  use GenServer
  require Logger

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :pdf}])
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, afirmacion}, 0) do
    Logger.debug(
      "[#{inspect(__MODULE__)}, process #{inspect(self())}] Non se puido validar #{inspect(afirmacion)}"
    )

    {:noreply, 0}
  end
end
