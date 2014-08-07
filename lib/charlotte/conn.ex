defmodule Charlotte.Conn do
  @moduledoc """
    The Charlotte Conn maintains all the connection information necessary for the lifecycle of a request.
  """

  @doc """
    A Charlotte Conn Struct contains the following data:

    * verb: HTTP Verb
    * params: Query String and all URL Bindings
    * headers: Request Headers
    * path: The request path
    * scheme: :http or :https
  """
  defstruct req: nil, verb: "", params: [], req_headers: "", headers: [], path: "", scheme: ""
end
