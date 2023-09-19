defmodule Decision do
  @moduledoc """
  Documentation for `Decision`.
  """

  use GenServer
  require Logger

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :busqueda}])
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, {state, afirmacion}}, 0) do
    case afirmacion[:tipo] do
	:poblacion -> GenServer.cast(:ige, {:validate, {state, afirmacion}})
	:paro -> 
		Logger.debug(
        		"[#{inspect(__MODULE__)}, process #{inspect(self())}] Recíbese petición #{inspect(afirmacion)}"
      		)		
		GenServer.cast(:datosmacro, {:validate, {state, afirmacion}})
    end
    {:noreply, 0}
  end

end
