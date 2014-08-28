defmodule :cowboy_req do
  def path(_), do: {"/bob", []}
  def method(_), do: {"GET", []}
  def headers(_), do: {"", []}
  def qs_vals(_), do: {[{"cat", "meow"}], []}
  def bindings(_), do: {[{:dog, "woof"}], []}
  def body_qs(_), do: {:ok, [{"fish", "glug"}], []}
end

defmodule Charlotte.ReqTest do
  use ExUnit.Case
  use ExSpec

  describe "normalize_to_atoms" do
    it "takes a list of tuples and ensures the first value in each tuple is an atom" do
      list = [{"cat", "puddy"}, {"bird", "tweety"}, {:rabbit, "rascaly"}]

      assert Charlotte.Req.normalize_to_atoms(list) == [{:rabbit, "rascaly"}, {:bird, "tweety"}, {:cat, "puddy"}]
    end
  end

  describe "build_conn" do
    it "returns a conn record with the data from the request" do
      conn = Charlotte.Req.build_conn([], [{:protocol, :tcp}])
      assert conn == %Charlotte.Conn{req: [], request_id: conn.request_id, verb: "GET", params: [cat: "meow", fish: "glug", dog: "woof"], req_headers: "", headers: [], path: "/bob", route: "/bob", scheme: :http}
    end
  end

  describe "add_header" do
    it "adds a header when there aren't any" do
      assert Charlotte.Req.add_header(%Charlotte.Conn{}, {"content-type", "text/html"}) == %Charlotte.Conn{headers: [{"content-type", "text/html"}]}
    end

    it "adds a header to an existing list" do
      conn = %Charlotte.Conn{headers: [{"content-type", "text/html"}]}

      assert Charlotte.Req.add_header(conn, {"location", "not-here"}) == %Charlotte.Conn{headers: [{"location", "not-here"}, {"content-type", "text/html"}]}
    end
  end
end
