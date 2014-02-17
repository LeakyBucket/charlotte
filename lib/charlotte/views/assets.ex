defmodule Charlotte.Views.Assets do
  @moduledoc """
    The Views.Assets module handles the rendering of any assets in the application.  By default any files in <APP_ROOT>/public/assets will be rendered by this view module.  

    The Assets module currently does not perform any kind of interpolation inside view files.  

    The Assets module is not responsible for setting the proper Mime Type on the response.  That is handled by the Assets Controller.  Keep this in mind if you call this module directly for whatever reason.
  """

  # TODO: For the future
  # When two assets have the same name the file to be rendered is detemined by extension.

  #   ```
  #     public/assets
  #       application.js
  #       application.css


  #     Charlotte.Views.Assets.application(:css)
  #     > "application.css content"

  #     Charlotte.Views.Assets.application(:js)
  #     > "application.js content"
  #   ```

  @doc """
    render returns the contents of  /<CHARLOTTE_ASSET_PATH>/<file>
  """
  def render(file) do
    File.read!(EnvConf.Server.get("CHARLOTTE_ASSET_PATH") <> "/#{file}")
  end
end