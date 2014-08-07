defmodule Charlotte.Views.AssetsTest do
  use ExUnit.Case
  use ExSpec

  describe "Rendering" do
    it "renders the requested asset" do
      assert Charlotte.Views.Assets.render("hello.css") == ".hello { color: green; }"
    end
  end
end
