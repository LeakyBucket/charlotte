defmodule FakeController do
  require Charlotte.Handlers.HTTP
  Charlotte.Handlers.HTTP.setup

  def routes do
    [{"/fake", :fake}]
  end
end

defmodule Charlotte.Handlers.HTTPTest do
  use Amrita.Sweet

  test "it responds to init" do
    FakeController.init({:tcp, :http}, [], [protocol: :tcp]) |> equals {:ok, [], :tcp}
  end

  test "it responds to handle" do
    assert FakeController.handle([], []) == []
  end

  test "it responds to terminate" do
    FakeController.terminate([], [], []) |> equals :ok
  end

  describe "Rendering" do

  end
end