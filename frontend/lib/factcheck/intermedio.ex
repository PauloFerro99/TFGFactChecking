defmodule Intermedio do
  @moduledoc """
  Documentation for `Intermedio`.
  """

  def buscar(texto, tipo) do
  	Recepcion.validar(%{:texto => texto, :canal => Factcheck.PubSub, :tipo => tipo})
  	
  end


end
