EnvConf.Server.start_link

defmodule Charlotte.DispatcherTest do
  use Amrita.Sweet

  test "it builds a list of routes and handlers" do
    path = [path: File.cwd! <> "/test/controllers"]
    route_list = Charlotte.Dispatcher.current_routes [path: File.cwd! <> "/test/controllers"]

    [{"/", Root, path}, {"/bobby", Bob, path}, {"/bob", Bob, path}] |> equals route_list
  end

  test "it finds the files at the given location" do
    path = Path.expand(File.cwd! <> "/test/support")

    Charlotte.Dispatcher.find_files(path) |> equals [path]
  end

  test "it loads the files in the list" do
    path = Path.expand(File.cwd! <> "/test/support")
    file = path <> "/config.exs"

    Charlotte.Dispatcher.load_controllers([file]) |> equals [Config]
  end
end