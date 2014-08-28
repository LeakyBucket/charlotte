defmodule Charlotte.ConnTest do
  use ExUnit.Case
  use ExSpec

  describe "defaults" do
    it "Doesn't set a default request_id" do
      refute %Charlotte.Conn{}.request_id
    end
  end
end
