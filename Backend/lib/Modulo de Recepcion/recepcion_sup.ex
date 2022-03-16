defmodule RecepcionSup do
    @moduledoc """
    Documentation for `RecepcionSup`.
    """
  
    use Supervisor

   # Public API

    def new() do
        Supervisor.start_link(__MODULE__, [], name: __MODULE__)
    end

    # Callbacks
 
    def init([]) do
        
        child = [%{
            id: Backend,
            start: {Recepcion, :new, []}
          }]

        Supervisor.init(child, strategy: :one_for_one)        
    end

end
