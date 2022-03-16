defmodule Recepcion do
  @moduledoc """
  Documentation for `Recepcion`.
  """

  use GenServer

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :server}])
  end

  def validar(afirmacion) do
    GenServer.call(:server, {:validate, afirmacion})
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_call({:validate, afirmacion}, _from, 0) do
    if is_binary(afirmacion) do
    	
      {:reply, GenServer.call(:busqueda, {:validate, afirmacion}), 0}
    else
      {:reply, :error, 0}
    end
  end

end