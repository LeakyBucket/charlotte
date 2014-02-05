defmodule :cowboy_req do
  def path(_), do: {"/bob", []}
  def method(_), do: {"GET", []}
  def headers(_), do: {"", []}
  def qs_vals(_), do: {[{"cat", "meow"}], []}
  def bindings(_), do: {[{:dog, "woof"}], []}
  def body_qs(_), do: {[{"fish", "glug"}], []}
end

defmodule Charlotte.ReqTest do
  use Amrita.Sweet

  describe "normalize_to_atoms" do
    it "takes a list of tuples and ensures the first value in each tuple is an atom" do
      list = [{"cat", "puddy"}, {"bird", "tweety"}, {:rabbit, "rascaly"}]

      Charlotte.Req.normalize_to_atoms(list) |> equals [{:rabbit, "rascaly"}, {:bird, "tweety"}, {:cat, "puddy"}]
    end
  end

  describe "build_conn" do
    it "returns a conn record with the data from the request" do
      Charlotte.Req.build_conn([], [{:protocol, :tcp}]) |> equals Charlotte.Req.Conn[req: [], verb: "GET", params: [cat: "meow", fish: "glug", dog: "woof"], req_headers: "", headers: [], path: "/bob", scheme: :http]
    end
  end

  describe "reply" do
    it "sends a reply to the client without a body" do
      provided [Charlotte.Req.Request.reply(_, _, _) |> true] do
        Charlotte.Req.reply(200, []) |> truthy
      end
    end

    it "sends a reply to the client with a body" do
      provided [Charlotee.Req.Request.reply(_, _, _, _) |> true] do
        Charlotte.Req.reply(200, "/bob", []) |> truthy
      end
    end
  end

  describe "add_header" do
    it "adds a header when there aren't any" do
      Charlotte.Req.add_header(Charlotte.Req.Conn[], {"content-type", "text/html"}) |> equals Charlotte.Req.Conn[headers: [{"content-type", "text/html"}]]
    end

    it "adds a header to an existing list" do
      conn = Charlotte.Req.Conn[headers: [{"content-type", "text/html"}]]

      Charlotte.Req.add_header(conn, {"location", "not-here"}) |> equals Charlotte.Req.Conn[headers: [{"location", "not-here"}, {"content-type", "text/html"}]]
    end
  end
end