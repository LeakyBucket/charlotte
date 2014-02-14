defmodule Charlotte.Views.CompilerTest do
  use Amrita.Sweet

  # Existing views:  fake_controller/new.eex, test_controller/new.eex, text_controller/create.eex

  describe "Production" do
    it "renders the view" do
      Charlotte.Views.Compiler.compile "production"

      Charlotte.Views.FakeController.new([pants: "Wearing them"]) |> equals "Wearing them\n"
    end

    it "doesn't render changes to view after compilation" do
      view = test_view_path <> "/fake_controller/new.eex"
      content = original_content(view)
      Charlotte.Views.Compiler.compile "production"

      write_to_file view, (content <> "<%= @lou %>")

      Charlotte.Views.FakeController.new([pants: "Check", lou: "ser"]) |> equals "Check\n"

      write_to_file view, content
    end
  end

  describe "Non-Production" do
    it "renders the view" do
      Charlotte.Views.Compiler.compile "development"

      Charlotte.Views.FakeController.new([pants: "Ooops!"]) |> equals "Ooops!\n"
    end

    it "renders updates to the view after compilation" do
      view = test_view_path <> "/fake_controller/new.eex"
      content = original_content(view)

      Charlotte.Views.Compiler.compile "development"

      write_to_file view, (content <> "<%= @lou %>")

      Charlotte.Views.FakeController.new([pants: "Check", lou: "ser"]) |> equals "Check\nser"

      write_to_file view, content
    end

    #TODO: Handle new views
  end

  defp test_view_path, do: Path.join([__DIR__, "../../views"]) |> Path.expand
  defp original_content(view), do: File.read!(view)
  defp write_to_file(file, content), do: File.write(file, content)
end