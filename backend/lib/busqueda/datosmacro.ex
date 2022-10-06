defmodule Datosmacro do
  @moduledoc """
  Documentation for `datosmacro`.
  """

  use GenServer
  require Logger

  use Tesla

  plug Tesla.Middleware.JSON, engine: Poison

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :datosmacro}])
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
      %{tipo: :paro, lugar: :espanha, ano: 2022} ->
        {:ok, response} = get("https://datosmacro.expansion.com/paro/espana")
	Logger.debug(
        	"[#{inspect(__MODULE__)}, process #{inspect(self())}] Recíbese petición #{inspect(afirmacion)}"
      	)	
        GenServer.cast(:exit, {:validate, %{:texto => "Respuesta 2", :canal => afirmacion[:canal]}})
    end
    {:noreply, 0}
  end
end
