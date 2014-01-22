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
    Enum.reduce gather_views(path), [], fn(view) ->
                                    view
                                  end
  end
  def compile(_env, path) do
    Enum.reduce gather_views(path), [], fn(view) ->
                                    view
                                  end
  end

  # Assuming .eex extension on all views
  defp gather_views(path) do
    
  end

  # Assuming controller/view.eex convention
  defp view_to_mod(view) do
    
  end

  # Compile the view for production
  # TODO: Decide on structure.  Does it make more sense to build separate module for each view or a function inside a Views submodule for the controller?
  defp compiled_view(mod_name, file) do
    # TODO: use EEx.function_from_file
  end

  # Compile the view for dev
  defp on_demand_view(mod_name, file) do
    # TODO: use EEx.eval_file
  end
end