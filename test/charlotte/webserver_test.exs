defmodule Charlotte.WebserverTest do
  use Amrita.Sweet

  test "it reloads the routes" do
    Charlotte.Webserver.update_routes |> equals :ok
  end

  test "it compiles the routes" do
    [{["localhost"], [], [{["favicon.ico"], [], :cowboy_static, {:file, EnvConf.Server.get("CHARLOTTE_ASSET_PATH") <> "/favicon.ico"}}, {["assets", :...], [], :cowboy_static, {:dir, EnvConf.Server.get("CHARLOTTE_ASSET_PATH")}}, {[], [], Root, []}, {["bobby"], [], Bob, []}, {["bob"], [], Bob, []}]}] |> equals Charlotte.Webserver.compile_routes
  end
end