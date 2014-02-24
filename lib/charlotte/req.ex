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
    {:ok, body_qs, req} = Request.body_qs req

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

  @doc """
    Takes a list of tuples and modifies it so that the first value in each tuple is an atom.  
  """
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

  @doc """
    Add a new header tuple for the response.  

    add_header takes two arguments a Charlotte.Req.Conn record and a header tuple.  
  """
  def add_header(conn, header), do: conn.headers([header] ++ conn.headers)

  @doc """
    Send the reply back to the Client.

    reply takes either a status and a conn record or a status, body and conn record.
    Any specific response headers should be set on the conn record prior to calling 
    reply.  
  """
  def reply(status, conn), do: Request.reply(status, conn.headers, conn.req)
  def reply(status, body, conn), do: Request.reply(status, conn.headers, body, conn.req)
  
  @doc """
    Send a file back to the client.  

    send_file takes the absolute path to the file and the Charlotte.Req.Conn Record for the current request.
  """
  def send_file(absolute_path, conn) do
    file_fun = fn(socket, transport) ->
                 transport.sendfile(socket, absolute_path)
               end

    Request.set_resp_body_fun(file_size(absolute_path), file_fun, conn.req)
  end
  
  # Get the file size for Cowboy
  defp file_size(path) do
    {:ok, stats} = File.stat path

    stats.size
  end

  # Set the scheme on the conn record
  defp scheme(:ssl), do: :https
  defp scheme(_), do: :http
end