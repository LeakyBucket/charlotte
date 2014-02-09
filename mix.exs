defmodule Charlotte.Mixfile do
  use Mix.Project

  def project do
    [ app: :charlotte,
      name: "Charlotte",
      version: "0.0.8",
      elixir: "~> 0.12.3",
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Charlotte, [] },
      registered: [:charlotte],
      env: [lager: [
          handlers: [
            {:lager_console_backend, :info},
            {:lager_file_backend, [{:file, "error.log"}, {:level, :error}]},
            {:lager_file_backend, [{:file, "console.log"}, {:level, :info}]},
          ]
        ]
      ]
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
      { :amrita, github: "josephwilk/amrita" }
    ] ++ deps(:default)
  end

  defp deps(env) when env == :default do
    [
      {:cowboy, github: "extend/cowboy" },
      {:exjson, github: "guedes/exjson"},
      {:plug, github: "elixir-lang/plug"},
      {:exlager, github: "khia/exlager"},
      {:ex_doc, github: "elixir-lang/ex_doc"},
      {:env_conf, github: "LeakyBucket/env_conf"}
    ]
  end
end
