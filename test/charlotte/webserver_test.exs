defmodule Charlotte.WebserverTest do
  use Amrita.Sweet

  test "it reloads the routes" do
    Charlotte.Webserver.update_routes(Config.config) |> equals :ok
  end

  test "it compiles the routes" do
    Charlotte.Webserver.compile_routes(Config.config) |> equals [{["localhost"], [], [{[], [], Root, [protocol: :tcp, acceptors: 100, compress: false, host: "localhost", port: 8080, path: "/Users/leakybucket/git/charlotte/test/controllers"]}, {["bobby"], [], Bob, [protocol: :tcp, acceptors: 100, compress: false, host: "localhost", port: 8080, path: "/Users/leakybucket/git/charlotte/test/controllers"]}, {["bob"], [], Bob, [protocol: :tcp, acceptors: 100, compress: false, host: "localhost", port: 8080, path: "/Users/leakybucket/git/charlotte/test/controllers"]}]}]
  end
end