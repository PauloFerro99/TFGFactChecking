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

  def handle_call({:validate, afirmacion}, _from, 0) do
    case afirmacion do
      "pdf" ->
            {:reply, GenServer.call(:pdf, {:validate, afirmacion}), 0} 
      "api" ->
            {:reply, GenServer.call(:api, {:validate, afirmacion}), 0} 
      "web" ->
            {:reply, GenServer.call(:web, {:validate, afirmacion}), 0} 
      _ -> 
            {:reply, GenServer.call(:web, {:validate, afirmacion}), 0} 
    end
    
  end

end