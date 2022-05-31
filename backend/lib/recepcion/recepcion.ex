defmodule Recepcion do
  @moduledoc """
  Documentation for `Recepcion`.
  """

  use GenServer
  require Logger

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :server}])
  end

  def validar(afirmacion) do
    GenServer.cast(:server, {:validate, afirmacion})
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, afirmacion}, 0) do
    if is_binary(afirmacion[:texto]) do
      Logger.debug(
        "[#{inspect(__MODULE__)}, process #{inspect(self())}] Recíbese petición #{inspect(afirmacion)}"
      )

      GenServer.cast(:busqueda, {:validate, afirmacion})
    end
    {:noreply, 0}
  end
end
