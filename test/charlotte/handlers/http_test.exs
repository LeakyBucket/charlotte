defmodule FakeController do
  use Charlotte.Handlers.HTTP
  
  def routes do
    [{"/bob", :bob}]
  end

  def bob(verb, params, conn) do
    :ok
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
      Module.defines?(FakeController, {:render, 3}) |> equals true
    end
  end
end