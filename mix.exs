defmodule Charlotte.Mixfile do
  use Mix.Project

  def project do
    [ app: :charlotte,
      name: "Charlotte",
      version: "0.2.1",
      elixir: "~> 0.15.0",
      description: description,
      package: package,
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Charlotte, [] },
      registered: [:charlotte]
    ]
  end

  
  defp deps do
    [ {:cowboy, "~> 1.0.0"},
      {:plug, "~> 0.5.2"},
      {:jazz, "~> 0.2.0"},
      {:env_conf, "~> 0.2.0"},
      {:hackney, github: "benoitc/hackney", only: :test},
      {:ex_spec, "~> 0.1.0", only: :test},
      {:ex_doc, "~> 0.5.1", only: :dev} ]
  end

  defp description do
    """
      Charlotte is a Web Framework.  It takes a little from Rails and a little from Sinatra and does a few things it's own way.  The goal is to be light weight, fun and get out of your way.
    """
  end

  defp package do
    [files: ["lib", "mix.exs", "README*", "readme*", "LICENSE*", "license*"],
     contributors: ["Glen Holcomb"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/LeakyBucket/charlotte.git"}]
  end
end
