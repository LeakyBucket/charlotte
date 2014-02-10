defmodule Charlotte.Webserver do
  @moduledoc """
    The Webserver handles the underlying cowboy process.
  """

  @doc """
    Start the Cowboy webserver with the given configuration.
  """
  def start do
    lc component inlist [:crypto, :public_key, :ssl, :mimetypes, :ranch, :cowlib, :cowboy], do: :application.start component

    router = compile_routes

    router |> start_server
  end

  @doc """
    Register a new set of routes with Cowboy.  This will perform a live update of the routes in the application.
  """
  def update_routes do
    # TODO: Make more robust (should handle both http and https)
    :cowboy.set_env(:http, :dispatch, compile_routes)
  end

  @doc """
    Compile new routes.  Routes will be read from current controllers.
  """
  def compile_routes do
    :cowboy_router.compile([{EnvConf.Server.get("CHARLOTTE_HOST"), Charlotte.Dispatcher.current_routes}])
  end

  # Start the webserver, the default is Cowboy.
  defp start_server(router) do
    {acceptors, compress, port, cacert, cert, key} = build_start_args

    case EnvConf.Server.get_atom("CHARLOTTE_PROTOCOL") do
      :ssl ->
        :cowboy.start_https :https, acceptors, [port, cacert, cert, key], [env: [dispatch: router]]
      :tcp ->
        :cowboy.start_http :http, acceptors, [port], [env: [dispatch: router], compress: compress]
    end
  end

  defp build_start_args do
    {
      EnvConf.Server.get_number("CHARLOTTE_ACCEPTORS"),
      EnvConf.Server.get_boolean("CHARLOTTE_COMPRESS"),
      {:port, EnvConf.Server.get_number("CHARLOTTE_PORT")},
      {:cacertfile, EnvConf.Server.get("CHARLOTTE_CACERT")},
      {:certfile, EnvConf.Server.get("CHARLOTTE_CERT")},
      {:keyfile, EnvConf.Server.get("CHARLOTTE_KEYFILE")}
    }
  end
end