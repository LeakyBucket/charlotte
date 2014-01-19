defmodule Charlotte.Mixfile do
  use Mix.Project

  def project do
    [ app: :charlotte,
      name: "Charlotte",
      version: "0.0.1",
      elixir: "~> 0.12.2",
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
      { :amrita, github: "LeakyBucket/amrita", branch: "format_entry_arity" }
    ] ++ deps(:default)
  end

  defp deps(env) when env == :default do
    [
      {:cowboy, github: "extend/cowboy" },
      {:exjson, github: "guedes/exjson"},
      {:plug, github: "elixir-lang/plug"},
      {:exlager, github: "khia/exlager"},
      {:ex_doc, github: "elixir-lang/ex_doc"}
    ]
  end
end
