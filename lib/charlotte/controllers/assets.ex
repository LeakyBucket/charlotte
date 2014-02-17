defmodule Charlotte.Controllers.Assets do
  @moduledoc """
    The Assets Controller handles all requests for /assets/*

    It it responsible for setting the appropriate Mime Type and sending the response.  Charlotte.Views.Assets is responsible for retrieving the actual content of the requested file.  
  """

  def routes do
    [
      {"/assets/[...]", :handle}
    ]
  end

  def init({:tcp, :http}, req, config) do
    {:ok, req, config}
  end

  def handle(req, state) do
    {asset, req} = req.path_info
    asset = asset_path(asset)

    asset_send = fn(socket, transport) ->
                   transport.sendfile(socket, asset)
                 end

    :cowboy_req.set_resp_body_fun(asset_size(asset), asset_send, req)
  end

  def terminate(_reason, _req, _state) do
    :ok
  end

  defp asset_size(resource) do
    {:ok, stats} = File.stat resource

    stats.size
  end

  defp asset_path(req_path) do
    EnvConf.Server.get("CHARLOTTE_ASSET_PATH") <> req_path
  end
end