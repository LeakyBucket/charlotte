defmodule Charlotte.DispatcherTest do
  use Amrita.Sweet

  test "it builds a list of routes and handlers" do
    route_list = Charlotte.Dispatcher.current_routes

    [{"/", Root, []}, {"/bobby", Bob, []}, {"/bob", Bob, []}] |> equals route_list
  end

  test "it finds the files at the given location" do
    {:ok, controllers} = File.ls(controller_dir)

    Charlotte.Dispatcher.find_files |> equals Enum.reverse(Enum.map(controllers, &("#{controller_dir}/" <> &1)))
  end

  test "it loads the files in the list" do
    path = Path.expand(File.cwd! <> "/test/support")
    file = path <> "/config.exs"

    Charlotte.Dispatcher.load_controllers([file]) |> equals [Config]
  end

  defp controller_dir, do: File.cwd! <> "/test/controllers"
end