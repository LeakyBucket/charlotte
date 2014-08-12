# Charlotte [![Gitter chat](https://badges.gitter.im/LeakyBucket/charlotte.png)](https://gitter.im/LeakyBucket/charlotte)

These are pretty sparse for now but should get better soon.

## What?

Charlotte is a Web Framework written in Elixir.  It takes after both Rails and Sinatra in some ways.  In other ways Charlotte is a different animal entirely.

## Why?

That's a good question.  When I first started playing with Elixir there weren't a ton of frameworks out there.  I decided that as part of learning the language I'd build one.

## Short How

The quickest way to get started is to add Charlotte as a dependency to your project.

```elixir
  { :charlotte, "~> 0.3.0" }
```

Once you have added and installed the dependency you are good to go.

There are a few different environment variables that Charlotte expects.  These can be set outside the application or defaults can be given to Charlotte.start/2

```elixir
  default_config = HashDict.new

  Charlotte.start [], [default_config: build_config(default_config)]

  def build_config(default_config) do
    default_config |>
      HashDict.put("CHARLOTTE_CONTROLLER_PATH", __DIR__ <> "/support/controllers") |>
      HashDict.put("CHARLOTTE_VIEW_PATH", __DIR__ <> "/support/views") |>
      HashDict.put("CHARLOTTE_ASSET_PATH", __DIR__ <> "/support/assets") |>
      HashDict.put("CHARLOTTE_HOST", "localhost") |>
      HashDict.put("CHARLOTTE_PROTOCOL", "tcp") |>
      HashDict.put("CHARLOTTE_ACCEPTORS", "100") |>
      HashDict.put("CHARLOTTE_COMPRESS", "false") |>
      HashDict.put("CHARLOTTE_PORT", "8000")
  end
```

## Long How

### Routes  

Routing in Charlotte is a bit different than most other frameworks.  Routes are actually a concern of the controller.  

```elixir
  defmodule MyController do
    use Charlotte.Handlers.HTTP

    def routes do
      [
        {"/", :root}
      ]
    end

    def root(verb, params, conn) do
      ...
    end
  end
```

Each Controller defines the routes that it is responsible for.  Charlotte expects this to be in the form of a list of path, action tuples.  The path should be a binary/string with the actual path that should be matched.  You can provide [Cowboy Style Bindings](http://ninenines.eu/docs/en/cowboy/HEAD/guide/routing/) in this path declaration.  These bindings will be present in the params passed to the action.  The action should always be an atom with the same name as the function to be called when that path is requested.  That function is assumed to exist in the module that defines the route.  

### Controllers

#### Organization

A Charlotte controller is simply a module that exists in the CHARLOTTE_CONTROLLER_PATH directory.  

```
  # Assuming CHARLOTTE_CONTROLLER_PATH environment var is set to "/var/www/app/controllers"

  $ ls /var/www/app/controllers
    users.ex
    fees.ex
    locations.ex
```

In the above example Charlotte would assume users.ex, fees.ex and locations.ex define controller modules.  

#### Content

In order for a controller module to be useful for Charlotte it needs to do the following:  

* Implement a routes function as described above
* Implement the appropriate Cowboy callbacks for the protocol it supports
* Handle view rendering and formatting and sending the response to the client  

It is possible to implement the last two requirements yourself or you can simply use the appropriate Charlotte Handler.  

```elixir
  defmodule MyController do
    use Charlotte.Handlers.HTTP

    ...
  end
```

The HTTP Handler will define the required callbacks for HTTP 1.1 in Cowboy as well as a few helpers for generating a response:  render/3 redirect/2 forbidden/1  

#### Responding  

The render function takes 3 arguments:  

* status
* bindings
* conn

The status is the integer status code that should accompany the response.  The default value is 200.  

The bindings should be a key: value list for the view.  The keys should map to variable names in your view.  

The conn is the conn record that was passed to your Controller action.  This is used in building and sending the response.  

The redirect function takes 2 arguments:  

* status
* conn

The status is the integer status code that should accompany the response.  The default is 302.  

The conn is the conn record that was passed to your Controller action.  This is used in building and sending the response.  

The forbidden function takes one argument:  

* conn

The conn is the conn record that was passed to your Controller action.  This is used in building and sending the response.  

### Views

#### Organization

Views in Charlotte are organized similarly to Views in Rails.  The view files for a controller are expected to be in a subdirectory of the CHARLOTTE_VIEW_PATH with the same name as the controller module that uses the view.  The actual view file is expected to have the same name as the controller action that renders it.  

```elixir
  # Assuming a CHARLOTTE_VIEW_PATH of "/var/www/app/views"

  $ ls -R /var/www/app/views
    ./users:
      show.ex
      new.ex
    ./fees:
      list.ex
    ./locations:
      new.ex
```

The above structure would result in the following code being generated:  

* Charlotte.Views.Users
  * show/1
  * new/1
* Charlotte.Views.Fees
  * list/1
* Charlotte.Views.Locations
  * new/1  

These are public functions and can be called from any where at any time.  However the render function which is injected by the HTTP Handler will look them up and call the appropriate function.

#### Content

Views are rendered by EEx.  Any assigned variables should be preceeded by an @  

```erb
  Your name is <%= @name %>
```

When you are running your application in development views will be read from the file each time they are called.  This means you don't need to restart the application to get changes to existing views.  However Charlotte doesn't pick up new view files unless it is restarted.  This is due to the way the views are structured when compiled.  

There are plans to build a default URL that when requested will cause a recompile of all Views.  

Charlotte currently doesn't have any helpers for link generation.  This is planned for the future.  

### Configuration

A brief word on configuration.  Charlotte is built to use a [12 Factor](http://12factor.net/config) approach to configuration.  

With this in mind the framework it's self expects a few configuration variables to be present:  

* CHARLOTTE_CONTROLLER_PATH
* CHARLOTTE_VIEW_PATH
* CHARLOTTE_ASSET_PATH
* CHARLOTTE_HOST
* CHARLOTTE_PROTOCOL
* CHARLOTTE_ACCEPTORS
* CHARLOTTE_COMPRESS
* CHARLOTTE_PORT  

Charlotte uses [EnvConf](https://github.com/LeakyBucket/env_conf) to manage configuration settings, this also allows you to use the same in your application without any additional setup.  

It is possible to send defaults when starting Charlotte from your application module:  

```elixir
  default_config = HashDict.new

  Charlotte.start [], [default_config: build_config(default_config)]

  def build_config(default_config) do
    default_config |>
      HashDict.put("CHARLOTTE_CONTROLLER_PATH", __DIR__ <> "/support/controllers") |>
      HashDict.put("CHARLOTTE_VIEW_PATH", __DIR__ <> "/support/views") |>
      HashDict.put("CHARLOTTE_ASSET_PATH", __DIR__ <> "/support/assets") |>
      HashDict.put("CHARLOTTE_HOST", "localhost") |>
      HashDict.put("CHARLOTTE_PROTOCOL", "tcp") |>
      HashDict.put("CHARLOTTE_ACCEPTORS", "100") |>
      HashDict.put("CHARLOTTE_COMPRESS", "false") |>
      HashDict.put("CHARLOTTE_PORT", "8000")
  end
```  

You can store/build these defaults however you wish.  All Charlotte cares about is that they are given as a HashDict.

EnvConf will not overwrite any values that are already present in the environment so it is safe to leave dev defaults in your code.  They won't overwrite configuration set in the environment directly on a production system.
