defmodule Charlotte.RouteAggregator do
  def current_routes(config) do
    controllers = find_files(config[:path]) |> require_controllers
  end

  def require_controllers(files) do
    compiled_mods = fn(file, acc) ->
                      mod_names(Code.load_file(file)) ++ acc
                    end

    Enum.reduce(files, [], compiled_mods)
  end

  def find_files(path) do
    File.ls path
  end

  defp mod_names(mod_list) do
    mod_extract = fn(mod_data, acc) ->
                    {mod, _} = mod_data
                    [mod] ++ acc
                  end

    Enum.reduce mod_list, [], mod_extract
  end
end