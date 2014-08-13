defmodule Charlotte.Req do
  @moduledoc """
    The Charlotte Request Handler contains functions for processing the Cowboy request object.
  """

  require :cowboy_req, as: Request

  @doc """
    Parse the cowboy response structure and build a Charlotte.Conn record.
  """
  def build_conn(req, config) do
    {path, req} = Request.path req
    {verb, req} = Request.method req
    {headers, req} = Request.headers req
    {params, req} = Request.qs_vals req
    {bindings, req} = Request.bindings req
    {:ok, body_qs, req} = Request.body_qs req

    params = bindings ++ body_qs ++ params
    route = path_with_bindings(path, bindings) |> String.rstrip ?/

    %Charlotte.Conn{
      req: req,
      verb: verb,
      params: normalize_to_atoms(params),
      req_headers: headers,
      headers: [],
      path: path,
      route: route,
      scheme: scheme(config[:protocol])
    }
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
                                [{String.to_atom(key), value}] ++ acc
                              end
                            end
  end

  @doc """
    Add a new header tuple for the response.

    add_header takes two arguments a Charlotte.Req.Conn record and a header tuple.
  """
  def add_header(conn, header), do: %{conn | headers: [header] ++ conn.headers}

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

  defp path_with_bindings(path, bindings) do
    restore_bindings(bindings, String.split(path, "/")) |> List.foldr "", &("#{&1}/#{&2}")
  end

  defp restore_bindings(bindings, path_parts) do
    Enum.map path_parts, fn(part) ->
      case List.keyfind(bindings, part, 1) do
        {binding, _} ->
          ":#{binding}"
        _ ->
          part
      end
    end
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
