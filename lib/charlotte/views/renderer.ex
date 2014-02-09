defmodule Charlotte.Views.Renderer do
  @moduledoc """
    The Views Renderer simply encapsulates helper logic for rendering eex templates associated with Controller Actions.  

    If a layout is specified then the view content is injected at the @content tag in the layout.

    ```
      <html>
        <head>
          <title>Test</title>
        </head>
        <body>
          <%= @content %>
        </body>
      </html>
    ```

    If no layout is specified (nil) then the view will be rendered as is.  

    render/4 should always return content suitable for immediate inclusion in the response body.
  """

  @doc """
    Render the specified view.  If a template is specified then the view content is injected into the @content tag in the layout.  Render always returns a binary.
  """
  def render(view_mod, view, bindings, template) when template == nil do
    view_content(view_mod, view, bindings)
  end
  def render(view_mod, view, bindings, template) do
    view_content(view_mod, view, bindings) |> render_template(template)
  end

  defp render_template(content, name) do
    Kernel.apply Charlotte.Views.Templates, name, [[content: content]]
  end

  defp view_content(mod, action, bindings) do
    Kernel.apply(mod, action, [bindings])
  end
end