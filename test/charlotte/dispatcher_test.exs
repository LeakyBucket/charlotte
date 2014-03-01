defmodule Charlotte.DispatcherTest do
  use Amrita.Sweet

  test "it builds a list of routes and handlers" do
    route_list = Charlotte.Dispatcher.current_routes

    [{'/favicon.ico', :cowboy_static, {:file, EnvConf.Server.get("CHARLOTTE_ASSET_PATH") <> "/favicon.ico"}}, {'/assets/[...]', :cowboy_static, {:dir, EnvConf.Server.get("CHARLOTTE_ASSET_PATH")}}, {'/', Root, []}, {'/bobby', Bob, []}, {'/bob', Bob, []}] |> equals route_list
  end

  test "it finds the files at the given location" do
    {:ok, controllers} = File.ls(controller_dir)

    Charlotte.Dispatcher.find_files |> equals Enum.reverse(Enum.map(controllers, &("#{controller_dir}/" <> &1)))
  end

  test "it loads the files in the list" do
    file = controller_dir <> "/bob.exs"

    Charlotte.Dispatcher.load_controllers([file]) |> equals [Bob]
  end

  defp controller_dir, do: EnvConf.Server.get "CHARLOTTE_CONTROLLER_PATH"
end