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
    GenServer.cast(:server, {:validate, afirmacion})
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, afirmacion}, 0) do
    if is_binary(afirmacion) do
      GenServer.cast(:busqueda, {:validate, afirmacion})
    end
    {:noreply, 0}
  end

end