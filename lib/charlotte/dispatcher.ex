defmodule Charlotte.Dispatcher do
  @moduledoc """
    The Dispatcher Module builds the proper data structure for Cowboy to use as a router.  
  """

  @doc """
    current_routes builds a list of tuples representing all the paths in the application as well as the module that handles that endpoint.

    The config param must have a path key which specifies where the controller files can be found.

    This function returns a list of tuples.  the tuples consist of the path, the module and the config data given to current_routes
  """
  def current_routes(config) do
    controllers = find_files(config[:path]) |> load_controllers

    # Get the routes from each controller then build dispatch list for Cowboy.
    path_builder = fn(mod, acc) ->
                     Enum.reduce(mod.routes, [], &([{&1, mod, config}] ++ &2)) ++ acc
                   end

    Enum.reduce controllers, [], path_builder
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
  def find_files(path) do
    {:ok, files} = File.ls path

    Enum.reduce files, [], fn(file, acc) -> 
                             [Path.join(path, file)] ++ acc 
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
end