defmodule Charlotte.DispatcherTest do
  use ExUnit.Case
  use ExSpec

  it "builds a list of routes and handlers" do
    route_list = Charlotte.Dispatcher.current_routes

    assert [{'/favicon.ico', :cowboy_static, {:file, EnvConf.Server.get("CHARLOTTE_ASSET_PATH") <> "/favicon.ico"}}, {'/assets/[...]', :cowboy_static, {:dir, EnvConf.Server.get("CHARLOTTE_ASSET_PATH")}}, {'/', Root, []}, {'/bobby', Bob, []}, {'/bob', Bob, []}] == route_list
  end

  it "finds the files at the given location" do
    {:ok, controllers} = File.ls(controller_dir)

    assert Charlotte.Dispatcher.find_files == Enum.reverse(Enum.map(controllers, &("#{controller_dir}/" <> &1)))
  end

  it "loads the files in the list" do
    file = controller_dir <> "/bob.exs"

    assert Charlotte.Dispatcher.load_controllers([file]) == [Bob]
  end

  defp controller_dir, do: EnvConf.Server.get "CHARLOTTE_CONTROLLER_PATH"
end
