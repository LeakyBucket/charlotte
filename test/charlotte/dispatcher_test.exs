defmodule Charlotte.DispatcherTest do
  use ExUnit.Case

  test "it builds a list of routes and handlers" do
    route_list = Charlotte.Dispatcher.current_routes Config.config

    assert [{"/", Root, _}, {"/bob", Bob, _}] = route_list
  end

  test "it finds the files at the given location" do
    path = Path.expand(File.cwd! <> "/test/support")

    assert Charlotte.Dispatcher.find_files(path) == {:ok, ["config.exs"]}
  end

  test "it loads the files in the list" do
    path = Path.expand(File.cwd! <> "/test/support")
    file = path <> "/config.exs"

    assert Charlotte.Dispatcher.require_controllers([file]) == [Config]
  end
end