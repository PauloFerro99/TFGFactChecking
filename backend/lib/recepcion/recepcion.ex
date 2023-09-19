defmodule Recepcion do
  @moduledoc """
  Documentation for `Recepcion`.
  """

  use GenServer
  require Logger

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :rec}])
  end

  def validar(afirmacion) do
    GenServer.cast(:rec, {:validate, afirmacion})
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 1}
  end

  def handle_cast({:validate, afirmacion}, state) do
    if is_binary(afirmacion[:texto]) do
      Logger.debug(
        "[#{inspect(__MODULE__)}, process #{inspect(self())}] Recíbese petición #{inspect(afirmacion)}"
      )

      GenServer.cast(:busqueda, {:validate, {state, afirmacion}})
    end
    {:noreply, state+1}
  end
end
