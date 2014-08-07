defmodule Charlotte.Mixfile do
  use Mix.Project

  def project do
    [ app: :charlotte,
      name: "Charlotte",
      version: "0.1.0",
      elixir: "~> 0.15.0",
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Charlotte, [] },
      registered: [:charlotte]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
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
end
