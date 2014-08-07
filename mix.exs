defmodule Charlotte.Mixfile do
  use Mix.Project

  def project do
    [ app: :charlotte,
      name: "Charlotte",
      version: "0.2.0",
      elixir: "~> 0.15.0",
      description: description,
      package: package,
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Charlotte, [] },
      registered: [:charlotte]
    ]
  end

  defp deps(env) when env in [:prod, :dev], do: deps(:default)
  defp deps(env) when env == :test do
    [
      { :hackney, github: "benoitc/hackney" },
      { :ex_spec, "~> 0.1.0"}
    ] ++ deps(:default)
  end

  defp deps(env) when env == :default do
    [
      {:cowboy, "~> 1.0.0" },
      {:plug, "~> 0.5.2"},
      {:jazz, "~> 0.2.0"},
      {:ex_doc, "~> 0.5.1"},
      {:env_conf, "~> 0.2.0"}
    ]
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
