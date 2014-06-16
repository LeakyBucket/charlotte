defmodule Charlotte.Controllers.NotFound do
  @moduledoc """
    The Charlotte.Controllers.NotFound module behaves as any other Charlotte controller.  The only difference being that it provides a catch all route and it loaded at the root of the dispatch list.

    This module has only one public function and even that is more of a framework internal behavior.  The whole job of the NotFound module is to handle requests for paths that aren't otherwise defined in the application.

    The NotFound module will render the not_found.eex template if it exists in the application othewise it will simply return a 404 response with no body content.
  """

  use Charlotte.Handlers.HTTP

  @layout :not_found

  def routes do
      [
        {"/[...]", :not_found}
      ]
  end

  def not_found(verb, params, conn) do
    if function_exported?(Charlotte.Views.Templates, :not_found, 1) do
      render 404, [], conn
    else
      default_response(conn)
    end
  end

  defp default_response(conn) do
    Charlotte.Req.reply 404, conn

    {:ok, conn.req, []}
  end

  defp render_template(conn) do
    

    {:ok, conn.req, []}
  end
end
