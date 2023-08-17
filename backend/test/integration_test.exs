defmodule IntegrationTest do
  use ExUnit.Case
  use Supervisor
  use GenServer


  test "Saida correcta" do
    IO.puts("TEST 4")
    children = [
      {Phoenix.PubSub, name: Test2.PubSub}
    ]
    opts = [strategy: :one_for_one, name: :testsupervisor]
    Supervisor.start_link(children, opts)

    Recepcion.new()
    pidr = Process.whereis(:rec)

    Decision.new()
    pidd = Process.whereis(:busqueda)

    Ige.new()
    pidi = Process.whereis(:ige)

    Salida.new()
    pids = Process.whereis(:exit)

    new()

    GenServer.cast(:rec, {:validate, %{:texto => "Poboación total que naceu e vive na Coruña", :datanum => "600831", :canal => Test2.PubSub, :tipo => :poblacion, :lugar => :corunha, :ano => 2011}})
    :timer.sleep(5000)

    [head | tail] = resultados()
    assert("Verdadeiro" == head)
  end




  def new() do
    GenServer.start_link(__MODULE__, [], [{:name, :result}])
  end

  def resultados() do
    GenServer.call(:result, {:res})
  end

  # Callbacks GenServer

  def init([]) do
    Phoenix.PubSub.subscribe(Test2.PubSub, "TFG")
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
