defmodule Charlotte.Handlers.HTTP do
  @moduledoc """
    The HTTP Handler module provides the basic HTTP 1.1 callbacks Cowboy expects in a route handler.  

    This is important because each controller in Charlotte is treated as a Reuqest Handler for the routes it defines.  

    To build an HTTP 1.1 Controller simply require this module and call the setup macro.  Your Controller Module
    should implement a routes method which returns a list of {path, action} tuples.
  """

  @doc """
    Using sets up the definitions for the default init, handle and terminate callbacks.  These callbacks assume
    the controller module API follows what is outlined in the documentation.  

    The handle callback is the most complex behavior wise.  It builds a Charlotte.Req.Conn Record, it looks
    up the action for the path and calls the action with the verb, params, and conn record.  

    setup also adds three convenience functions for crafting responses for the client:  

    * render(status \\ 200, bindings, conn)  
    * redirect(status \\ 302, conn)  
    * forbidden(conn)  
  """
  defmacro __using__(_args) do
    quote do
      @layout nil

      def init({:tcp, :http}, req, config) do
        {:ok, req, config}
      end

      def handle(req, state) do
        conn = Charlotte.Req.build_conn req, state
        action = find_action(routes, conn.path)

        # Invoke the proper action for the path
        Kernel.apply(__MODULE__, action, [conn.verb, conn.params, conn])

        {:ok, req, state}
      end

      def terminate(_reason, _req, _state) do
        :ok
      end

      defp find_action([route | rest], path) do
        case route do
          {^path, action} ->
            action
          _ ->
            find_action(rest, path)
        end
      end

      defp render(status \\ 200, bindings, conn) do
        body = Charlotte.Views.Renderer.render(__MODULE__, find_action(routes, conn.path), bindings, @layout)
        conn = conn |> Charlotte.Req.add_header {"content-type", "text/html"}

        Charlotte.Req.reply(status, body, conn)
      end

      defp redirect(status \\ 302, conn), do: Charlotte.Req.reply(status, conn)
      defp forbidden(conn), do: Charlotte.Req.reply(403, conn)

      defoverridable Module.definitions_in(__MODULE__)
    end
  end
end
