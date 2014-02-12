defmodule Charlotte.WebserverTest do
  use Amrita.Sweet

  test "it reloads the routes" do
    Charlotte.Webserver.update_routes |> equals :ok
  end

  test "it compiles the routes" do
    Charlotte.Webserver.compile_routes |> equals [{["localhost"], [], [{[], [], Root, []}, {["bobby"], [], Bob, []}, {["bob"], [], Bob, []}]}]
  end
end