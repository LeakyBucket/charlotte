defmodule Charlotte.WebserverTest do
  use ExUnit.Case
  use ExSpec

  test "it reloads the routes" do
    assert Charlotte.Webserver.update_routes == :ok
  end

  test "it compiles the routes" do
    assert [{["localhost"], [], [{[:...], [], Charlotte.Controllers.NotFound, []}, {["favicon.ico"], [], :cowboy_static, {:file, EnvConf.Server.get("CHARLOTTE_ASSET_PATH") <> "/favicon.ico"}}, {["assets", :...], [], :cowboy_static, {:dir, EnvConf.Server.get("CHARLOTTE_ASSET_PATH")}}, {[], [], Root, []}, {["bobby"], [], Bob, []}, {["bob"], [], Bob, []}]}] == Charlotte.Webserver.compile_routes
  end
end
