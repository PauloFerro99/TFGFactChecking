defmodule UnitTest do
  use ExUnit.Case
  use Supervisor



  test "Os procesos seguen vivos tras recibir datos correctos" do
    IO.puts("TEST 1")
    children = [
      {Phoenix.PubSub, name: Test.PubSub}
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

    GenServer.cast(:rec, {:validate, %{:texto => "Tasa de paro total en España", :datanum => "12,7%", :canal => Test.PubSub, :tipo => :paro, :lugar => :espanha}})
    :timer.sleep(5000)
    
    assert (true == Process.alive?(pidr))
    assert (true == Process.alive?(pidd))
    assert (true == Process.alive?(pidi))
    assert (true == Process.alive?(pids))

    Process.exit(pidr, :kill)
    Process.exit(pidd, :kill)
    Process.exit(pidi, :kill)
    Process.exit(pids, :kill)
  end




  test "Os procesos morren tras recibir datos incorrectos" do
    IO.puts("TEST 2")

    Recepcion.new()
    pidr = Process.whereis(:rec)

    Decision.new()
    pidd = Process.whereis(:busqueda)

    Ige.new()
    pidi = Process.whereis(:ige)

    Salida.new()
    pids = Process.whereis(:exit)



    
    GenServer.cast(:rec, {:a, %{:hola => 1}})
    :timer.sleep(1000)

    GenServer.cast(:ige, {:a, %{:hola => 1}})
    :timer.sleep(1000)

    GenServer.cast(:exit, {:a, %{:hola => 1}})
    :timer.sleep(1000)

    GenServer.cast(:busqueda, {:a, %{:hola => 1}})
    :timer.sleep(5000)
    
    assert (false == Process.alive?(pidr))
    assert (false == Process.alive?(pidd))
    assert (false == Process.alive?(pidi))
    assert (false == Process.alive?(pids))
  end





  test "Os procesos seguen vivos tras recibir datos incorrectos mentres estan supervisados" do
    IO.puts("TEST 3")

    RecepcionSup.new()
    pidr = Process.whereis(:rec)

    DecisionSup.new()
    pidd = Process.whereis(:busqueda)

    IgeSup.new()
    pidi = Process.whereis(:ige)

    SalidaSup.new()
    pids = Process.whereis(:exit)


    GenServer.cast(:rec, {:a, %{:hola => 1}})
    :timer.sleep(1000)

    GenServer.cast(:busqueda, {:a, %{:hola => 1}})
    :timer.sleep(1000)

    GenServer.cast(:ige, {:a, %{:hola => 1}})
    :timer.sleep(1000)

    GenServer.cast(:exit, {:a, %{:hola => 1}})
    :timer.sleep(5000)
    
    pidr = Process.whereis(:rec)
    pidd = Process.whereis(:busqueda)
    pidi = Process.whereis(:ige)
    pids = Process.whereis(:exit)

    assert (true == Process.alive?(pidr))
    assert (true == Process.alive?(pidd))
    assert (true == Process.alive?(pidi))
    assert (true == Process.alive?(pids))
  end

end
