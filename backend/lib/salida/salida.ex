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
    Logger.debug("[#{inspect(__MODULE__)}, process #{inspect(self())}] A saída é #{inspect(res[:texto])} #{inspect(res[:datanum])}")
    if (to_string(res[:texto]) == res[:datanum]) do
      Phoenix.PubSub.broadcast(res[:canal], "TFG", {:res, "Verdadeiro"})
    else
      Phoenix.PubSub.broadcast(res[:canal], "TFG", {:res, "Falso"})
    end
    {:noreply, 0}
  end
end
