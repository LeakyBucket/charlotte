defmodule Charlotte.Dispatcher do
  @moduledoc """
    The functions in Charlotte.Dispatcher are intended for building a proper structure for Cowboy's routing.  

    The functions in Charlotte.Dispatcher make a few assumptions about the structure of the underlying application.  

    * All controllers are assumed to be at the given path.  
    * Each controller module must contain a routes function.  
      * routes must return a list of tuples in the form of {path, action}  

  """

  @doc """
    current_routes builds a list of tuples representing all the paths in the application as well as the module that handles that endpoint.

    This function returns a list of tuples.  the tuples consist of the path, the module and an empty list for the initial Cowboy handler state.
  """
  def current_routes do
    controllers = find_files |> load_controllers

    # Get the routes from each controller then build dispatch list for Cowboy.
    path_builder = fn(mod, acc) ->
                     Enum.reduce(mod.routes, [], fn(route, acc) ->
                       {path, _} = route
                       [{bitstring_to_list(path), mod, []}] ++ acc
                     end) ++ acc
                   end

    Enum.reduce(controllers, [], path_builder) |> add_assets
  end

  @doc """
    load_controllers takes a list of file names (absolute path).  It compiles each file and returns a list of the modules that were generated.
  """
  def load_controllers(files) do
    compiled_mods = fn(file, acc) ->
                      mod_names(Code.load_file(file)) ++ acc
                    end

    Enum.reduce(files, [], compiled_mods)
  end

  @doc """
    find_files returns a list of all the files found at the given path.
  """
  def find_files do
    location = EnvConf.Server.get "CHARLOTTE_CONTROLLER_PATH"
    {:ok, files} = File.ls location

    Enum.reduce files, [], fn(file, acc) -> 
                             [Path.join(location, file)] ++ acc 
                           end
  end

  # Return a list of all the module names when given a list of compiled modules
  # Expects a list of tuples with {Module, <<binary>>} format.
  defp mod_names(mod_list) do
    mod_extract = fn(mod_data, acc) ->
                    {mod, _} = mod_data
                    [mod] ++ acc
                  end

    Enum.reduce mod_list, [], mod_extract
  end

  # Add the internal Assets controller to the dispatch list.
  #defp add_assets(dispatch_list), do: [{'assets/[...]', :cowboy_static, [{:directory, {:priv_dir, :my_app, []}]}, {'/favicon.ico', :cowboy_static, [{:directory, {:priv_dir, :my_app, []}}, {:file, "favicon.ico"}]}]
  defp add_assets(dispatch_list), do: [{'/assets/[...]', Charlotte.Controllers.Assets, []}, {'/favicon.ico', Charlotte.Controllers.Assets, []}] ++ dispatch_list
end