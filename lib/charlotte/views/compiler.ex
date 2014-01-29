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
  # TODO: Break into separate functions?
  defp gather_views(path) do
    {:ok, contents} = File.ls(path)

    Enum.reduce contents, [], fn(file, acc) ->
                                target = Path.join(path, file)
                                if File.dir?(target) do
                                  gather_views(target) ++ acc
                                else
                                  [target] ++ acc 
                                end
                              end
  end

  # Build a dict of module names and action -> view lists
  #
  #  Charlotte.Views.ControllerName => [{:action_name, file}]
  defp view_dict(views) do
    Enum.reduce views, HashDict.new, fn(file, acc) ->
                                       HashDict.update acc, view_to_mod(file), [{action(file), file}], &([{action(file), file}] ++ &1)
                                     end
  end

  # Assuming views/controller/view.eex convention
  defp view_to_mod(view) do
    [controller | rest] = drop_preamble String.split(view, "/")

    Module.concat ["Charlotte", "Views", camelize(controller)]
  end

  # camelize a given binary
  defp camelize(name) do
    String.split(name, "_") |> Enum.map_join &(String.capitalize(&1))
  end

  defp action(file) do
    String.split(file, "/") |> List.last |> String.split(".") |> List.first |> binary_to_atom
  end

  # Drop the beginning of the path
  defp drop_preamble(["views" | tail]), do: tail
  defp drop_preamble([head | tail]), do: drop_preamble(tail)

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