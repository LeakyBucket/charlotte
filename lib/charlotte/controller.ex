defmodule Charlotte.Controller do
  defmacro setup do
    quote do
      def init({:tcp, :http}, req, config) do

      end

      def handle(req, state) do

      end

      def terminate(_reason, _req, _state) do
        :ok
      end
    end  
  end
end