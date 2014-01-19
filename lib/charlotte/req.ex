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
  def build_conn(req, config) do
    {path, req} = R.path req
    {verb, req} = R.method req
    {headers, req} = R.headers req
    {params, req} = R.qs_vals req
    {bindings, req} = R.bindings req
    {body_qs, req} = R.body_qs req

    params = bindings ++ body_qs ++ params

    Conn[
      verb: verb,
      params: normalize_to_atoms(params),
      headers: headers,
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

  defp scheme(:ssl), do: :https
  defp scheme(_), do: :http
end