defmodule Charlotte.Conn do
  @moduledoc """
    The Charlotte Conn maintains all the connection information necessary for the lifecycle of a request.
  """

  @doc """
    A Charlotte Conn Struct contains the following data:

    * request_id: Randomly generated ID for the request
    * verb: HTTP Verb
    * params: Query String and all URL Bindings
    * headers: Request Headers
    * path: The request path
    * route: The route for the request
    * scheme: :http or :https
  """
  defstruct req: nil, request_id: nil, verb: "", params: [], req_headers: "", headers: [], path: "", route: "", scheme: ""
end
