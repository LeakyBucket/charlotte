defmodule Charlotte.Views.CompilerTest do
  use ExUnit.Case
  use ExSpec

  # Existing views:  fake_controller/new.eex, test_controller/new.eex, text_controller/create.eex

  describe "Production" do
    it "renders the view" do
      Charlotte.Views.Compiler.compile :prod

      assert Charlotte.Views.FakeController.new([pants: "Wearing them"]) == "Wearing them\n"
    end

    it "doesn't render changes to view after compilation" do
      view = test_view_path <> "/fake_controller/new.eex"
      content = original_content(view)
      Charlotte.Views.Compiler.compile :prod

      write_to_file view, (content <> "<%= @lou %>")

      assert Charlotte.Views.FakeController.new([pants: "Check", lou: "ser"]) == "Check\n"

      write_to_file view, content
    end
  end

  describe "Non-Production" do
    it "renders the view" do
      Charlotte.Views.Compiler.compile :dev

      assert Charlotte.Views.FakeController.new([pants: "Ooops!"]) == "Ooops!\n"
    end

    it "renders updates to the view after compilation" do
      view = test_view_path <> "/fake_controller/new.eex"
      content = original_content(view)

      Charlotte.Views.Compiler.compile :dev

      write_to_file view, (content <> "<%= @lou %>")

      assert Charlotte.Views.FakeController.new([pants: "Check", lou: "ser"]) == "Check\nser"

      write_to_file view, content
    end

    #TODO: Handle new views
  end

  defp test_view_path, do: EnvConf.Server.get("CHARLOTTE_VIEW_PATH") |> Path.expand
  defp original_content(view), do: File.read!(view)
  defp write_to_file(file, content), do: File.write(file, content)
end
