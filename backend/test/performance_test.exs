defmodule PerformanceTest do
  use ExUnit.Case
  use Supervisor
  use GenServer

  @tag timeout: :infinity
  test "Rendemento" do
    n = 300
    f = 33

    #Creamos canle pubsub de test
    children = [
      {Phoenix.PubSub, name: TestP.PubSub}
    ]
    opts = [strategy: :one_for_one, name: :testsupervisor]
    Supervisor.start_link(children, opts)

    #Arrancamos os procesos do pipeline
    RecepcionSup.new()

    DecisionSup.new()

    IgeSup.new()

    DatosmacroSup.new()

    SalidaSup.new()

    #Arrancamos o genserver de test
    new()

    #Lanzamos as consultas

    timePet = consultas(n, [], f)
   
    :timer.sleep(10000)

    timeRes = resultados()

    auxlist = Enum.zip(timePet, timeRes)

    timeList = Enum.map(auxlist, fn {x, y} -> 
      IO.puts(DateTime.diff(y, x, :millisecond))
      IO.puts(" ")
      DateTime.diff(y, x, :millisecond)
    end)

    IO.puts(Enum.sum(timeList)/(n*2))
    
  end


  defp consultas(0, list, f) do
    list
  end

  defp consultas(n, list, f) do
    GenServer.cast(:rec, {:validate, %{:texto => "Tasa de paro total en España",
     :datanum => "110%", :canal => TestP.PubSub, :tipo => :paro, :lugar => :espanha}})

    {:ok, t} = DateTime.now("Etc/UTC")
    l = [t | list]

    GenServer.cast(:rec, {:validate, %{:texto => "Poboación total que naceu e vive na Coruña",
     :datanum => "500", :canal => TestP.PubSub, :tipo => :poblacion, :lugar => :corunha, :ano => 2011}})

    {:ok, t} = DateTime.now("Etc/UTC")
    l = [t | l]

    :timer.sleep(f)

    consultas(n-1, l, f)
  end


  def new() do
    GenServer.start_link(__MODULE__, [], [{:name, :perf}])
  end

  def resultados() do
    GenServer.call(:perf, {:res})
  end

  # Callbacks GenServer

  def init([]) do
    Phoenix.PubSub.subscribe(TestP.PubSub, "TFG")
    {:ok, []}
  end

  def handle_call({:res}, _, state) do
    {:reply, state, state}
  end

  def handle_info({:res, texto}, state) do
    {:ok, time} = DateTime.now("Etc/UTC")
    updated_state = [time | state]
    {:noreply, updated_state}
  end

end
