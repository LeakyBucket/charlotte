defmodule Charlotte.Handlers.WebSocket do
  @moduledoc """
    
  """

  defmacro __using__(args) do
    quote do
      def init({:tcp, :http}, req, config) do
        {:upgrade, :protocol, :cowboy_websocket}
      end

      def websocket_init(transport, req, opts) do
        
      end
      
      def websocket_handle(data, req, state) do
        
      end
      
      def websocket_info(info, req, state) do
        
      end
      
      def websocket_terminate(_reason, _req, _state) do
        :ok
      end
    end
  end
end