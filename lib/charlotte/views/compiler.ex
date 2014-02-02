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
    Enum.reduce comp_dict(path), [], fn(view, acc) ->
                                    {mod, actions} = view
                                    [on_demand_view(mod, actions)] ++ acc
                                  end
  end
  def compile(_env, path) do
    Enum.reduce comp_dict(path), [], fn(view, acc) ->
                                    {mod, actions} = view
                                    [compiled_view(mod, actions)] ++ acc
                                  end
  end

  # build the compilation dict
  defp comp_dict(path) do
    path |> gather_views |> view_dict
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

  # Compile the view for production
  defp compiled_view(mod_name, actions) do
    defmodule mod_name do
      require EEx

      Enum.each actions, fn(action) ->
                           {name, file} = action
                           EEx.function_from_file(:def, name, file, [:assigns])
                         end
    end
  end

  # Compile the view for dev
  # TODO: Handle new views.
  defp on_demand_view(mod_name, actions) do
    defmodule mod_name do
      require EEx

      Enum.each actions, fn(action) ->
                            {name, file} = action
                            quoted = quote bind_quoted: [name: name, file: file] do
                              def unquote(name)(assigns) do
                                EEx.eval_file(unquote(file), assigns: assigns)
                              end
                            end

                            Module.eval_quoted mod_name, quoted
                          end
    end
  end

  # Drop the beginning of the path
  defp drop_preamble(["views" | tail]), do: tail
  defp drop_preamble([head | tail]), do: drop_preamble(tail)
end