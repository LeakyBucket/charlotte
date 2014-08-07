defmodule Charlotte.Views.Templates do
  def application(content), do: "template #{content[:content]}"
end

defmodule Charlotte.Views.Test do
  def view(content), do: "view #{content}"
end

defmodule Charlotte.Views.RendererTest do
  use ExUnit.Case
  use ExSpec

  describe "render" do
    it "applies the proper template" do
      assert Charlotte.Views.Renderer.render(Charlotte.Views.Test, :view, "cat", :application) == "template view cat"
    end

    it "renders the specified view" do
      assert Charlotte.Views.Renderer.render(Charlotte.Views.Test, :view, "cat", nil) == "view cat"
    end
  end
end
