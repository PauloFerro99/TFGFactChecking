defmodule Arranque do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  def start() do
    RecepcionSup.new()
    DecisionSup.new()
    IgeSup.new()
    SalidaSup.new()
  end

end
