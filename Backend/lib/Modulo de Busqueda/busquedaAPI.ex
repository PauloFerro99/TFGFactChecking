defmodule BusquedaAPI do
  @moduledoc """
  Documentation for `BusquedaAPI`.
  """

  use GenServer
  use Tesla

  plug Tesla.Middleware.JSON

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :api}])
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, afirmacion}, 0) do
    case afirmacion do

      _ -> 
            {:ok, response} = get("https://www.ige.gal/igebdt/igeapi/json/datos/5261/0:1,1:5,2:2,9912:15,3:2011")
            if response.status == 200 do
              GenServer.cast(:exit, {:validate, response.body})
            else
              GenServer.cast(:exit, {:validate, "Non se puido saber"})
            end
    end
    {:noreply, 0}
  end

end