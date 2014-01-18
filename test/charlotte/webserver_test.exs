defmodule Charlotte.WebserverTest do
  use ExUnit.Case

  test "it starts a regular http server" do
    assert Charlotte.Webserver.start(Config.config) == {:ok}
  end

  test "it reloads the routes" do
    assert Charlotte.Webserver.update_routes(Config.config) == :ok
  end

  test "it compiles the routes" do
    assert Charlotte.Webserver.compile_routes(Config.config) == [:ok]
  end
end