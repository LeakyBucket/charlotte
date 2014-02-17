defmodule FakeController do
  use Charlotte.Handlers.HTTP
  
  def routes do
    [{"/bob", :bob}]
  end

  def bob(verb, params, conn) do
    render [], conn
  end
end

defmodule Charlotte.Handlers.HTTPTest do
  use Amrita.Sweet

  describe "setup" do
    it "Adds the init callback for Cowboy" do
      FakeController.init({:tcp, :http}, [], []) |> equals {:ok, [], []}
    end

    # it "Adds the handle callback for Cowboy" do
    #   FakeController.handle([], []) |> equals :ok
    # end

    it "Adds the terminate callback for Cowboy" do
      FakeController.terminate([], [], []) |> equals :ok
    end

    # it "Adds the render function" do
    #   provided [FakeController.render(_, _, _) |> :ok, FakeController.bob(_, _, _) |> FakeController.render] do
    #     FakeController.bob("GET", [param: "param"], []) |> equals :ok
    #   end
    # end
  end
end