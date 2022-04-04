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

  def handle_cast({:validate, "pdf"}, 0) do
    GenServer.cast(:pdf, {:validate, "pdf"})
    {:noreply, 0}
  end

  def handle_cast({:validate, "api"}, 0) do
    GenServer.cast(:api, {:validate, "api"})
    {:noreply, 0}
  end

  def handle_cast({:validate, "web"}, 0) do
    GenServer.cast(:web, {:validate, "web"})
    {:noreply, 0}
  end
end
