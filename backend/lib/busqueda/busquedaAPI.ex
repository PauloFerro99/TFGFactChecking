defmodule BusquedaAPI do
  @moduledoc """
  Documentation for `BusquedaAPI`.
  """

  use GenServer
  require Logger

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :api}])
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
