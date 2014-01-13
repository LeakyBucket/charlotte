defmodule Charlotte.Handlers.HTTP do
  import Plug.Connection

  @connection Plug.Adapters.Cowboy.Connection

  defrecord State, protocol: nil

  def init({:tcp, :http}, req, config) do
    {:ok, req, set_state(config)}
  end

  def handle(req, state) do
    conn = @connection.conn req, state.protocol
  end
  
  def terminate(_reason, _req, _state) do
    :ok
  end

  defp set_state(config) do
    State.new protocol: config[:protocol]
  end
end