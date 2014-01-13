defmodule Webserver do
  def start(options) do
    lc component inlist [:crypto, :public_key, :ssl, :mimetypes, :ranch, :cowlib, :cowboy], do: :application.start component

    router = :cowboy_router.compile([{binary_to_atom(options[:host]), [{'/[...]', Handlers.HTTP, options}]}])

    router |> start_server(options)
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