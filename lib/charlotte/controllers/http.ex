defmodule Charlotte.Controllers.HTTP do
  import Plug.Connection

  @connection Plug.Adapters.Cowboy.Connection

  defrecord State, protocol: nil

  # TODO: We should log here
  def init({:tcp, :http}, req, config) do
    {:ok, req, set_state(config)}
  end

  # TODO: Log here too
  def handle(req, state) do
    
  end
  
  # TODO: This should definitely log.
  def terminate(_reason, _req, _state) do
    
  end
  
  defp set_state(config) do
    State.new protocol: config[:protocol]
  end
end