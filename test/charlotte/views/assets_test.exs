defmodule Charlotte.Views.AssetsTest do
  use Amrita.Sweet

  describe "Rendering" do
    it "renders the requested asset" do
      Charlotte.Views.Assets.render("hello.css") |> equals ".hello { color: green; }"
    end
  end
end