defmodule Charlotte.Req do
  @moduledoc """
    The Charlotte Request Handler contains functions for processing the Cowboy request object.
  """

  require :cowboy_req, as: Request

  @doc """
    The Conn organizes the data from the request.  It associates the data in a way that should be useful for a controller action.
  """
  defrecord Conn,
    verb: "",
    params: [],
    headers: "",
    path: "",
    scheme: ""

  @doc """
    Parse the cowboy response structure and build a native Conn record.  

    A Charlotte Conn Record is structured as follows:  
    * verb: HTTP Verb
    * params: Query String and all URL Bindings
    * headers: Request Headers
    * path: The request path
    * scheme: :http or :https
  """
  def parse(req, config) do
    {path, req} = R.path req
    {verb, req} = R.method req
    {headers, req} = R.headers req
    {params, req} = R.qs_vals req

    Conn[
      verb: verb,
      params: add_bindings(params, req),
      headers: headers,
      path: path,
      scheme: scheme(config[:protocol])
    ]
  end

  defp add_bindings(params, req) do
    R.bindings(req) ++ params
  end

  defp scheme(:tcp), do: :http
  defp scheme(:ssl), do: :https
end