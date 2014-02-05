defmodule Charlotte.Logger do
  require Lager

  def debug(message) do
    Lager.debug message
  end
  
  def info(message) do
    Lager.info message
  end
end