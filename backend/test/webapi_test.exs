defmodule WebAPITest do
  use ExUnit.Case

  test "an HTTP request to an existing API returns a response" do
    url = "https://www.ige.gal/igebdt/igeapi/json/datos/5261/0:1,1:5,2:2,9912:15,3:2011"
    assert match?({:ok, _response}, Tesla.get(url))
  end

  test "an HTTP request to an existing API returns a valid bitstring" do
    url = "https://www.ige.gal/igebdt/igeapi/json/datos/5261/0:1,1:5,2:2,9912:15,3:2011"
    {:ok, response} = Tesla.get(url)
    assert response.body |> is_bitstring
  end

  test "an HTTP request to an existing API returns a valid JSON" do
    url = "https://www.ige.gal/igebdt/igeapi/json/datos/5261/0:1,1:5,2:2,9912:15,3:2011"
    {:ok, response} = Tesla.get(url)
    assert match?({:ok, _map}, Poison.decode(response.body))
  end

  test "an HTTP request to an existing API returns a valid JSON that Poison can turn into a map" do
    url = "https://www.ige.gal/igebdt/igeapi/json/datos/5261/0:1,1:5,2:2,9912:15,3:2011"
    {:ok, response} = Tesla.get(url)
    {:ok, map} = Poison.decode(response.body)

    assert is_map(map)
  end
end
