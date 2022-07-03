defmodule Decision do
  @moduledoc """
  Documentation for `Decision`.
  """

  use GenServer

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :busqueda}])
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, afirmacion}, 0) do
    if afirmacion[:tipo] == :poblacion do
      GenServer.cast(:ige, {:validate, afirmacion})
    end
    {:noreply, 0}
  end

end
