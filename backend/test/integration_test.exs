defmodule IntegrationTest do
  use ExUnit.Case
  use Supervisor
  use GenServer


  test "Saidas ige" do
  #Creamos canle pubsub de test
    IO.puts("TEST IGE")
    children = [
      {Phoenix.PubSub, name: Test2.PubSub}
    ]
    opts = [strategy: :one_for_one, name: :testsupervisor]
    Supervisor.start_link(children, opts)

  #Arrancamos os procesos do pipeline
    RecepcionSup.new()
    pidr = Process.whereis(:rec)

    DecisionSup.new()
    pidd = Process.whereis(:busqueda)

    IgeSup.new()
    pidi = Process.whereis(:ige)

    SalidaSup.new()
    pids = Process.whereis(:exit)

  #Arrancamos o genserver de test
    new()

  #Lanzamos as consultas
    GenServer.cast(:rec, {:validate, %{:texto => "Poboación total que naceu e vive na Coruña",
     :datanum => "600831", :canal => Test2.PubSub, :tipo => :poblacion, :lugar => :corunha, :ano => 2011}})
    :timer.sleep(5000)

    GenServer.cast(:rec, {:validate, %{:texto => "Poboación total que naceu e vive na Coruña",
     :datanum => "500", :canal => Test2.PubSub, :tipo => :poblacion, :lugar => :corunha, :ano => 2011}})
    :timer.sleep(5000)

  #Comprobamos o resultado
    [head | tail] = resultados()
    assert("Falso" == head)

    [h | t] = tail
    assert("Verdadeiro" == h)
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
