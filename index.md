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

