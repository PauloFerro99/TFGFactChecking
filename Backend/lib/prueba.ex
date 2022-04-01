defmodule Prueba do
  @moduledoc """
  Documentation for `Prueba`.
  """

  use Tesla

  plug Tesla.Middleware.JSON

  def test() do
    {:ok, response} = get("https://www.ige.gal/igebdt/igeapi/json/datos/5261/0:1,1:5,2:2,9912:15,3:2011")
    response.body |> Jason.decode
  end
end
