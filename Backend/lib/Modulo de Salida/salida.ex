defmodule Salida do
  @moduledoc """
  Documentation for `Salida`.
  """

  use GenServer

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :exit}])
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, res}, 0) do
    IO.puts(res)
    {:noreply, 0}
  end

end