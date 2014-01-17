defmodule Charlotte.DispatcherTest do
  use ExUnit.Case

  test "it builds a list of routes and handlers" do
    path = [path: File.cwd! <> "/test/controllers"]
    route_list = Charlotte.Dispatcher.current_routes [path: File.cwd! <> "/test/controllers"]

    assert [{"/", Root, path}, {"/bobby", Bob, path}, {"/bob", Bob, path}] == route_list
  end

  test "it finds the files at the given location" do
    path = Path.expand(File.cwd! <> "/test/support")

    assert Charlotte.Dispatcher.find_files(path) == [Path.join(File.cwd!, "test/support/config.exs")]
  end

  test "it loads the files in the list" do
    path = Path.expand(File.cwd! <> "/test/support")
    file = path <> "/config.exs"

    assert Charlotte.Dispatcher.load_controllers([file]) == [Config]
  end
end