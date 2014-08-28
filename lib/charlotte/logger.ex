defmodule Charlotte.Logger do
  require Logger

  def begin(conn) do
    Logger.metadata request_id: conn.request_id
    Logger.info "Starting #{conn.verb} request for #{conn.path}"
  end

  def finish(conn) do
    Logger.metadata request_id: conn.request_id
    Logger.info "Finishing #{conn.verb} request for #{conn.path}"
  end

  def debug(message) do
    Logger.debug message
  end

  def info(message) do
    Logger.info message
  end
end
