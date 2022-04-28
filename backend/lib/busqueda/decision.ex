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

  def handle_cast({:validate, "ige"}, 0) do
    GenServer.cast(:ige, {:validate, "ige"})
    {:noreply, 0}
  end

end
