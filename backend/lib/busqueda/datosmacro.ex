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

  def handle_cast({:validate, {state, afirmacion}}, 0) do
    Logger.debug(
      "[#{inspect(__MODULE__)}, process #{inspect(self())}] Non se puido validar #{inspect(afirmacion)}"
    )
    
    case afirmacion do
      %{tipo: :paro, lugar: :espanha} ->
        {:ok, response} = get("https://datosmacro.expansion.com/paro/espana")
	{:ok, document} = Floki.parse_document(response.body)
	a = Floki.find(document, "table tr")
	b = Enum.map(a, &parse/1)
	Logger.debug("#{inspect(b)}")
	c = Enum.find(b, &aux/1)
	Logger.debug("#{inspect(c)}")
	res = Map.get(c, :total)
	Logger.debug("#{inspect(res)}")
	Logger.debug(
        	"[#{inspect(__MODULE__)}, process #{inspect(self())}] Recíbese petición #{inspect(afirmacion)}"
      	)	
        GenServer.cast(:exit, {:validate, %{:texto => res, :n => state, :canal => afirmacion[:canal], :datanum => afirmacion[:datanum]}})
    end
    {:noreply, 0}
  end

  defp parse(
      {"tr", _, 
        [
          {"td", _, [{_, _, [tipo]}]}, 
          {"td", _, [total]}, 
          {"td", _, [hombres]}, 
          {"td", _, [mujeres]}
        ]
      }
    ) do
    %{tipo: tipo, total: total, hombres: hombres, mujeres: mujeres}
  end

  defp parse(_) do
     %{}
  end


  defp aux(map) do
    if Map.has_key?(map, :tipo) do
      if (Map.get(map, :tipo) == "Tasa de desempleo [+]") do
        true
      else
        false
      end
    else
      false
    end
  end
end
