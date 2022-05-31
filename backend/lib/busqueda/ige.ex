defmodule Ige do
  @moduledoc """
  Documentation for `ige`.
  """

  use GenServer
  require Logger

  use Tesla

  plug Tesla.Middleware.JSON, engine: Poison

  # Public API

  def new() do
    GenServer.start_link(__MODULE__, 0, [{:name, :ige}])
  end

  # Callbacks GenServer

  def init(0) do
    {:ok, 0}
  end

  def handle_cast({:validate, afirmacion}, 0) do
    Logger.debug(
      "[#{inspect(__MODULE__)}, process #{inspect(self())}] Non se puido validar #{inspect(afirmacion)}"
    )

    {:ok, response} = get("https://www.ige.gal/igebdt/igeapi/jsonstat/datos/5261")
    GenServer.cast(:exit, {:validate, %{:texto => response.body, :canal => afirmacion[:canal]}})

    {:noreply, 0}
  end
end
