defmodule FactcheckWeb.PageController do
  use FactcheckWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def proccessing(conn, params) do
    case Map.get(params, "data") do
	"1" -> Intermedio.buscar(%{:texto => Map.get(params, "data"), :datanum => Map.get(params, "datanum"),:canal => Factcheck.PubSub, :tipo => :poblacion, :lugar => :corunha, :ano => 2011})
	"2" -> Intermedio.buscar(%{:texto => Map.get(params, "data"), :datanum => Map.get(params, "datanum"), :canal => Factcheck.PubSub, :tipo => :paro, :lugar => :espanha})
    end
    render(conn, "procc.html")
  end

  def result(conn, _params) do
    lista = Resultado.resultados()
    render(conn, "result.html", list: lista)
  end

end
