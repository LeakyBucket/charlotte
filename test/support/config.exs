defmodule Config do
  def config do
    [
      protocol: :tcp,
      acceptors: 100,
      compress: false,
      host: "localhost",
      port: 8080
    ]
  end
end