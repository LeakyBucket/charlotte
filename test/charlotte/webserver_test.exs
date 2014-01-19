defmodule Charlotte.WebserverTest do
  use Amrita.Sweet

  test "it starts a regular http server" do
    Charlotte.Webserver.start(Config.config) |> equals {:ok}
  end

  test "it reloads the routes" do
    Charlotte.Webserver.update_routes(Config.config) |> equals :ok
  end

  test "it compiles the routes" do
    Charlotte.Webserver.compile_routes(Config.config) |> equals [:ok]
  end
end