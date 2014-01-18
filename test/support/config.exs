defmodule Config do
  def config do
    [
      protocol: :tcp,
      acceptors: 100,
      compress: false,
      host: "localhost",
      port: 8080,
      path: File.cwd! <> "/test/controllers"
    ]
  end
end