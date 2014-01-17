defmodule Charlotte.Dispatcher do
  def current_routes(config) do
    controllers = find_files(config[:path]) |> load_controllers

    # Get the routes from each controller then build dispatch list for Cowboy.
    path_builder = fn(mod, acc) ->
                     Enum.reduce(mod.routes, [], &([{&1, mod, config}] ++ &2)) ++ acc
                   end

    Enum.reduce controllers, [], path_builder
  end

  # Reload all the controller files.
  def load_controllers(files) do
    compiled_mods = fn(file, acc) ->
                      mod_names(Code.load_file(file)) ++ acc
                    end

    Enum.reduce(files, [], compiled_mods)
  end

  # Get a list of all the files at the given path (Intended to find controllers here)
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