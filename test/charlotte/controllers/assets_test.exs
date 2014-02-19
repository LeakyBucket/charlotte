defmodule FakeReq do
  def path do
    {"/assets/"}
  end
end

defmodule Charlotte.Controllers.AssetsTest do
  use Amrita.Sweet

  describe "Routing" do
    it "defines a global route for /assets" do
      Charlotte.Controllers.Assets.routes |> equals [{"/assets/[...]", :handle}]
    end
  end
end