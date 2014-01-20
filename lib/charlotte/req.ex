defmodule Charlotte.Req do
  @moduledoc """
    The Charlotte Request Handler contains functions for processing the Cowboy request object.
  """

  require :cowboy_req, as: Request

  @doc """
    The Conn organizes the data from the request.  It associates the data in a way that should be useful for a controller action.
  """
  defrecord Conn,
    req: nil,
    verb: "",
    params: [],
    req_headers: "",
    headers: [],
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
  def build_conn(req, config) do
    {path, req} = Request.path req
    {verb, req} = Request.method req
    {headers, req} = Request.headers req
    {params, req} = Request.qs_vals req
    {bindings, req} = Request.bindings req
    {body_qs, req} = Request.body_qs req

    params = bindings ++ body_qs ++ params

    Conn[
      req: req,
      verb: verb,
      params: normalize_to_atoms(params),
      req_headers: headers,
      headers: [],
      path: path,
      scheme: scheme(config[:protocol])
    ]
  end

  def normalize_to_atoms(params) do
    Enum.reduce params, [], fn(pair, acc) ->
                              {key, value} = pair
                              if is_atom(key) do
                                [{key, value}] ++ acc
                              else
                                [{binary_to_atom(key), value}] ++ acc
                              end
                            end
  end

  def add_header(conn, header), do: conn.headers([header] ++ conn.headers)

  def reply(status, conn), do: Request.reply(status, conn.headers, conn.req)
  def reply(status, body, conn), do: Request.reply(status, conn.headers, body, conn.req)
  
  defp scheme(:ssl), do: :https
  defp scheme(_), do: :http
end