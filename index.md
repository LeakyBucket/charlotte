---
layout: default
---

```elixir
  defmodule Users do  
    use Charlotte.Handlers.HTTP  

    def routes do
      [
        {"/users", :index},
        {"/user/:id", :show}
      ]
    end

    def users(_verb, params, conn) do
      users = UserFinder.all

      render [users: users], conn
    end
  end
```  

<br />

## Charlotte is

A web-framework written entirely in Elixir.  

Charlotte is similar to [Sinatra](http://www.sinatrarb.com/) in
that it aims to be small and stay out of your way.  

Charlotte is similar to [Rails](http://rubyonrails.org/) in that
it tries to take care of tedium for you.  

## Charlotte is not

Charlotte is not like a majority of other frameworks. It aims
to be as modular as possible.  In the future this will include
handling multiple protocols in the same application, everything
from Websocket and SPDY to HTTP 2.0.  

Charlotte is not like [Rails](http://rubyonrails.org/) in that
it does not come with a persistence library.  

Charlotte is not yet mature enough for production.  It is a
definite work in progress.  

## Quick and Dirty

In order to get started with Charlotte you need to add it as a
dependency.

```elixir
  {:charlotte, '~> 0.3.0'}
```

After installing Charlotte you can start using it in your
application.  

In order for Charlotte to listen and handle requests it needs
to be started. This would usually be done in the `start` function
for your application. Charlotte doesn't require any special
arguments to start however it does expect a bit of [configuration](https://github.com/LeakyBucket/charlotte#configuration).
This can either be set in the environment or it can be passed to
`Charlotte.start/2`.  

The following values need to be set before starting Charlotte or
given as an argument to `Charlotte.start/2`.  

* CHARLOTTE\_CONTROLLER\_PATH
* CHARLOTTE\_VIEW\_PATH
* CHARLOTTE\_ASSET\_PATH
* CHARLOTTE\_HOST
* CHARLOTTE\_PROTOCOL
* CHARLOTTE\_ACCEPTORS
* CHARLOTTE\_COMPRESS
* CHARLOTTE\_PORT

## Controllers

Each controller in Charlotte is a single Elixir module. The
controller consists of a `Charlotte.Handler`, route definitions
and functions representing actions.  

The handler defines the callbacks necessary for Cowboy to use
your module as a protocol handler.  Cowboy supports several
protocols and eventually Charlotte will too but for now we only
support `HTTP 1.1`.  

```elixir
  use Charlotte.Handlers.HTTP
```

Each controller defines the routes it is responsible for directly
in the controller module. Routes are defined in the form of a
list of `{path, action}` tuples where the `path` is given as a
string and the `action` is an atom.

```elixir
  def routes do
    [
      {"/", :root},
      {"/one", :level_one}
    ]
  end
```

The handler will handle looking up the action based on the path
and calling the proper function in your controller module.  

Every action accepts three arguments: the HTTP verb, request
parameters and a connection record.

```elixir
  def level_one(_verb, _params, conn) do
    render [level: "one"], conn
  end
```

In the above example the render function causes Charlotte to
render the `level_one.eex` file located in the `CHARLOTTE_VIEW_PATH`
for the controller module (`$CHARLOTTE_VIEW_PATH/<CONTROLLER_NAME>/level_one.eex`).  

## Views

Currently Charlotte only supports `EEx` for it's templating,
however there are plans to add `Haml` in the near future.  

All views live in the directories in the `CHARLOTTE_VIEW_PATH`
location.  Views are expected to be [EEx](http://elixir-lang.org/docs/stable/eex/)
templates and should be named the same as the controller action
that renders them.

```erb
  <p>This is the level_one view</p>

  <p>The level is <%= @level %></p>
```

## Assets

Last but not least, assets. Assets can be served by Charlotte
just like anything else. Assets are mapped to `/assets/[...]`,
that is a catch-all route that will match any path starting
with `/assets/`.  Cowboy should be smart enough to determine
the file type and respond appropriately.
