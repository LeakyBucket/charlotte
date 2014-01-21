defmodule Charlotte do
  @moduledoc """
    Charlotte is an Elixir Web Framework.  It is inspired by both Rails and Sinatra.  

    Charlotte doesn't come with any particular ORM nor does it expect you to use one.  That doesn't mean you can't and it also means you can use whichever you want.  

    Charlotte does expect you to use the Cowboy webserver.  We may branch out to others in the future but the current architecture closely reflects Cowboy's structure and behaviors.   

    In Charlotte your controllers define both your request handling and your application routing.  Charlote will read the routes defined in each controller and dispatch requests for those routes to the specified action.  

    For example:  

    ```
    defmodule MyController do
      require Charlotte.Handlers.HTTP
      Charlotte.Handlers.HTTP.setup

      def routes do
        [
          {"action1", :action1},
          {"action2", :action2}
        ]
      end

      def action1(verb, params, conn) do
        
      end
      
      def action2(verb, params, conn) do
        
      end
    end
    ```

    Assuming no other controllers Charlotte will handle requests to action1 and action2 and those will be passed to the action1 and action2 functions respectively.

    This is different from most other routing configurations out there but we feel it allows for a nice encapsulation of expression.
  """

  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    Charlotte.Webserver.start Config.config

    Charlotte.Supervisor.start_link
  end
end
