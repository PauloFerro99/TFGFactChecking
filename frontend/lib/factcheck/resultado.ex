defmodule Resultado do
  @moduledoc """
  Documentation for `Resultado`.
  """

  use GenServer
  require Logger

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, [], [{:name, :result}])
  end

  def resultados() do
    GenServer.call(:result, {:res})
  end

  # Callbacks GenServer

  def init([]) do
    Phoenix.PubSub.subscribe(Factcheck.PubSub, "TFG")
    {:ok, []}
  end

  def handle_call({:res}, _, state) do
    {:reply, state, state}
  end

  def handle_info({:res, texto}, state) do
    updated_state = [texto | state] 
    {:noreply, updated_state}
  end
end
