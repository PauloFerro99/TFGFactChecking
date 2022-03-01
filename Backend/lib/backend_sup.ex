defmodule BackendSup do
    @moduledoc """
    Documentation for `BackendSup`.
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
            start: {Backend, :new, []}
          }]

        Supervisor.init(child, strategy: :one_for_one)        
    end

end
