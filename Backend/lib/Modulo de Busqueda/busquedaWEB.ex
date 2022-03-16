defmodule BusquedaWEB do
  @moduledoc """
  Documentation for `BusquedaWEB`.
  """

  use GenServer

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :web}])
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_call({:validate, afirmacion}, _from, 0) do
    case afirmacion do

      _ -> 
            {:reply, "Non se puido saber", 0}
    end

  end

end