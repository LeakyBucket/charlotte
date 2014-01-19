defmodule Charlotte.Handlers.HTTP do
  @moduledoc """
    The HTTP Handler module provides the basic HTTP 1.1 callbacks Cowboy expects in a route handler.  

    To build an HTTP 1.1 Controller simply require this module and call the setup macro.  Your Controller Module
    should implement a routes method which returns a list of {path, action} tuples.
  """

  @doc """
    The setup macro returns the definitions for the default init, handle and terminate callbacks.  These callbacks assume
    the controller module API follows what is outlined in the documentation.
  """
  defmacro setup do
    quote do
      def init({:tcp, :http}, req, config) do
        {:ok, req, config[:protocol]}
      end

      def handle(req, state) do
        conn = Charlotte.Req.build_conn req, state
        action = find_action(conn.path)

        # Invoke the proper action for the path
        Code.eval_quoted quote do: __MODULE__.unquote(action)
      end

      def terminate(_reason, _req, _state) do
        :ok
      end

      defp find_action(path) do
        {path, action} = Enum.find routes, fn(x) ->
                                             {rel, action} = x
                                             rel == path
                                           end

        action
      end
    end  
  end
end