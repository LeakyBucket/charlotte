defmodule Charlotte.Views.Compiler do
  @moduledoc """
    The Views Compiler builds view modules for all the view files found at the specified path.  

    During development the views will interpret the file on each render.  Otherwise the views will be read and converted into functions via the EEx function_from_file macro.  

    
  """

  @doc """
    Compile the views found at path.  

    If the env param is "dev" or "development" then the View module will load the View on every request.  Otherwise the view will be compiled ahead of time.
  """
  def compile(env, path) when env in ["dev", "development"] do
    
  end
  def compile(_env, path) do
    
  end
  
  
end