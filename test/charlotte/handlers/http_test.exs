defmodule FakeController do
  require Charlotte.Handlers.HTTP
  Charlotte.Handlers.HTTP.setup

  def routes do
    [{"/fake", :fake}]
  end
end

defmodule Charlotte.Handlers.HTTPTest do
  use Amrita.Sweet

  describe "setup" do
    it "Adds the init callback for Cowboy" do
      FakeController.init({:tcp, :http}, [], [protocol: :tcp]) |> equals {:ok, [], :tcp}
    end

    it "Adds the handle callback for Cowboy" do
      FakeController.handle([], []) |> equals :ok
    end

    it "Adds the terminate callback for Cowboy" do
      FakeController.terminate([], [], []) |> equals :ok
    end

    it "Adds the render function" do
      
    end
  end
end