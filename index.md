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

Charlotte is not yet mature enough for production.  It is a
definite work in progress.  
