defmodule FakeController do
  use Charlotte.Handlers.HTTP

  def routes do
    [{"/bob", :bob}]
  end
end

defmodule Charlotte.Handlers.HTTPTest do
  use ExUnit.Case
  use ExSpec

  describe "__using__" do
    it "Adds the init callback for Cowboy" do
      assert function_exported?(FakeController, :init, 3)
    end

    it "Adds the handle callback for Cowboy" do
      assert function_exported?(FakeController, :handle, 2)
    end

    it "Adds the terminate callback for Cowboy" do
      assert function_exported?(FakeController, :terminate, 3)
    end
  end
end
