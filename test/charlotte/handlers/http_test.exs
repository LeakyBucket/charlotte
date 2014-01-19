Code.require_file "test/test_helper.exs", File.cwd!

defmodule FakeController do
  require Charlotte.Handlers.HTTP
  Charlotte.Handlers.HTTP.setup
end

defmodule Charlotte.Handlers.HTTPTest do
  use Amrita.Sweet

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