defmodule Ige do
  @moduledoc """
  Documentation for `ige`.
  """

  use GenServer
  require Logger

  use Tesla

  plug Tesla.Middleware.JSON, engine: Poison

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :ige}])
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, afirmacion}, 0) do
    Logger.debug(
      "[#{inspect(__MODULE__)}, process #{inspect(self())}] Non se puido validar #{inspect(afirmacion)}"
    )
    
    case afirmacion do
      %{tipo: :poblacion, lugar: :corunha, ano: 2011} ->
        {:ok, response} = get("https://www.ige.eu/igebdt/igeapi/jsonstat/datos/5261/0:1,1:0,2:0,3:2011,9912:15")
	ini = elem(:binary.match(String.to_charlist(response.body), "["), 0)
	fin = elem(:binary.match(String.to_charlist(response.body), "]"), 0)
	respuesta = String.slice(response.body, ini, fin - ini)
        GenServer.cast(:exit, {:validate, %{:texto => respuesta, :canal => afirmacion[:canal]}})
    end
    {:noreply, 0}
  end
end
