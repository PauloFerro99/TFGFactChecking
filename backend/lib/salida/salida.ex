defmodule Salida do
  @moduledoc """
  Documentation for `Salida`.
  """

  use GenServer
  require Logger

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :exit}])
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, res}, 0) do
    Logger.debug("[#{inspect(__MODULE__)}, process #{inspect(self())}] A saída é #{inspect(res[:texto])}")
    Phoenix.PubSub.broadcast(res[:canal], "TFG", {:res, %{res: res[:texto]}})
    {:noreply, 0}
  end
end
