defmodule Charlotte.Controllers.Assets do
  @moduledoc """
    The Assets Controller handles all requests for /assets/*  

    It also handles the favicon.  
  """

  def routes do
    [
      {"/assets/[...]", :send_asset},
      {"/favicon.ico", :send_favicon}
    ]
  end

  def init({:tcp, :http}, req, config) do
    {:ok, req, config}
  end

  def handle(req, state) do
    Kernel.apply(__MODULE__, routes[req.path], [req])
  end

  def send_asset(req) do
    {asset, req} = req.path_info
    asset = asset_path(asset)

    asset_send = fn(socket, transport) ->
                   transport.sendfile(socket, asset)
                 end

    :cowboy_req.set_resp_body_fun(file_size(asset), asset_send, req)
  end

  def send_favicon(req) do
    icon = asset_path("/favicon.ico")

    icon_send = fn(socket, transport) ->
                  transport.sendfile(socket, icon)
                end

    :cowboy_req.set_resp_body_fun(file_size(icon), icon_send, req)
  end
  
  def terminate(_reason, _req, _state) do
    :ok
  end

  defp file_size(resource) do
    {:ok, stats} = File.stat resource

    stats.size
  end

  defp asset_path(req_path) do
    EnvConf.Server.get("CHARLOTTE_ASSET_PATH") <> req_path
  end
end