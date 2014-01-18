defmodule FakeController do
  require Charlotte.Handlers.HTTP
  Charlotte.Handlers.HTTP.setup
end

defmodule Charlotte.Handlers.HTTPTest do
  use ExUnit.Case

  test "it responds to init" do
    assert FakeController.init({:tcp, :http}, [], []) == []
  end

  test "it responds to handle" do
    assert FakeController.handle([], []) == []
  end

  test "it responds to terminate" do
    assert FakeController.terminate([], [], []) == :ok
  end
end