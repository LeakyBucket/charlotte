defmodule Charlotte.RouteAggregatorTest do
  use ExUnit.Case

  test "it builds a list of routes and handlers" do
    route_list = Charlotte.RouteAggregator.current_routes

    assert [{"/", Root, _}, {"/bob", Bob, _}] = route_list
  end

  test "it finds the files at the given location" do
    path = Path.expand(File.cwd! <> "/../support")

    assert Charlotte.RouteAggregator.find_files(path) == []
  end

  test "it loads the files in the list" do
    path = Path.expand(File.cwd! <> "/test/support")
    file = path <> "/config.exs"

    assert Charlotte.RouteAggregator.require_controllers([file]) == [Config]
  end
end