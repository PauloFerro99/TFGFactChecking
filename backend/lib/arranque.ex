defmodule Arranque do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    RecepcionSup.new()
    DecisionSup.new()
    IgeSup.new()
    DatosmacroSup.new()
    SalidaSup.new()
  end

end
