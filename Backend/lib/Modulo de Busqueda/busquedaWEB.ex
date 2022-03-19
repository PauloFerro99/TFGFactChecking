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

  def handle_cast({:validate, afirmacion}, 0) do
    case afirmacion do

      _ -> 
            GenServer.cast(:exit, {:validate, "Non se puido saber"})
    end
    {:noreply, 0}
  end

end