defmodule Charlotte.Controllers.NotFoundTest do
  use Amrita.Sweet

  describe "routes" do
    it "defines a catch all route" do
      Charlotte.Controllers.NotFound.routes |> equals [{"/[...]", :not_found}]
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
