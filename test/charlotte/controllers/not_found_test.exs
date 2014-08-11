defmodule Charlotte.Controllers.NotFoundTest do
  use ExUnit.Case
  use ExSpec

  describe "routes" do
    it "defines a catch all route" do
      Charlotte.Controllers.NotFound.routes == [{"/[...]", :not_found}]
    end
  end

  # describe "missing" do
  #   it "calls Charlotte.Views.Layouts.not_found" do
  #     provided [Charlotte.Views.Templates.not_found(_) |> "404"] do
  #       Charlotte.Controllers.NotFound.not_found("GET", "your_mom.html", [])
  #     end
  #   end
  # end
end
