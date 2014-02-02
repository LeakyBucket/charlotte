defmodule Charlotte.Views.CompilerTest do
  use Amrita.Sweet

  # Existing views:  fake_controller/new.eex, test_controller/new.eex, text_controller/create.eex

  describe "Production" do
    it "renders the view" do
      Charlotte.Views.Compiler.compile "production", test_view_path

      Charlotte.Views.FakeController.new([pants: "Wearing them"]) |> equals "Wearing them\n"
    end

    it "doesn't render changes to view after compilation" do

    end
  end

  describe "Non-Production" do
    it "renders the view" do
      Charlotte.Views.Compiler.compile "development", test_view_path

      Charlotte.Views.FakeController.new([pants: "Ooops!"]) |> equals "Ooops!\n"
    end

    it "renders updates to the view after compilation" do

    end

    #TODO: Handle new views
  end

  defp test_view_path, do: Path.join([__DIR__, "../../views"]) |> Path.expand
end