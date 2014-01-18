defmodule Charlotte.Webserver do
  @moduledoc """
    The Webserver handles the underlying cowboy process.
  """

  @doc """
    start is pretty self explanatory.  It takes a keyword list of configuration settings
  """
  def start(options) do
    lc component inlist [:crypto, :public_key, :ssl, :mimetypes, :ranch, :cowlib, :cowboy], do: :application.start component

    router = compile_routes(options)

    router |> start_server(options)
  end

  @doc """
    update_routes takes a keyword list of options.  It recompiles the routes and updates the cowboy process with the newly compiled dispatcher.
  """
  def update_routes(options) do
    # TODO: Make more robust (should handle both http and https)
    :cowboy.set_env(:http, :dispatch, compile_routes(options))
  end

  @doc """
    
  """
  def compile_routes(options) do
    :cowboy_router.compile([{options[:host], Charlotte.Dispatcher.current_routes(options)}])
  end

  # Start the webserver, the default is Cowboy.
  defp start_server(router, options) do
    {acceptors, compress, port, cacert, cert, key} = build_start_args(options)

    case options[:protocol] do
      :ssl ->
        :cowboy.start_https :https, acceptors, [port, cacert, cert, key], [env: [dispatch: router]]
      :tcp ->
        :cowboy.start_http :http, acceptors, [port], [env: [dispatch: router], compress: compress]
    end
  end

  defp build_start_args(options) do
    {
      options[:acceptors],
      options[:compress],
      {:port, options[:port]},
      {:cacertfile, options[:cacertfile]},
      {:certfile, options[:certfile]},
      {:keyfile, options[:keyfile]}
    }
  end
end