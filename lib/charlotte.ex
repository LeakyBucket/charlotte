defmodule Charlotte do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Charlotte.Webserver.start Config.config

    Charlotte.Supervisor.start_link
  end
end
