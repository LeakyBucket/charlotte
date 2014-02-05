defmodule Charlotte.LoggerTest do
  use Amrita.Sweet

  describe "Debug" do
    it "writes to debug.log" do
      Charlotte.Logger.debug "Debug"
    end
  end

  describe "Info" do
    it "writes to console.log" do
      Charlotte.Logger.info "Info"
    end
  end
end