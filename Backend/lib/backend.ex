defmodule Backend do
  @moduledoc """
  Documentation for `Backend`.
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
    case afirmacion do
    	true ->	{:reply, true, 0}
    
    	false -> {:reply, false, 0}

    	_ -> {:reply, :error, 0}
    end
  end

end
