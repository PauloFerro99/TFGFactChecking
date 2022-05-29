defmodule FactcheckWeb.PageController do
  use FactcheckWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def proccessing(conn, params) do
    Intermedio.buscar(Map.get(params, "data"))
    render(conn, "procc.html")
  end

end
