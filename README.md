# Charlotte [![Gitter chat](https://badges.gitter.im/LeakyBucket/charlotte.png)](https://gitter.im/LeakyBucket/charlotte)

These are pretty sparse for now but should get better soon.

## What

Charlotte is a Web Framework written in Elixir.  It takes after both Rails and Sinatra in some ways.  In other ways Charlotte is a different animal entirely.

## Why

That's a good question.  When I first started playing with Elixir there weren't a ton of frameworks out there.  I decided that as part of learning the language I'd build one.

## Short How

<!-- The quickest way to get started is to add Charlotte as a dependency to your project.

```elixir
  { :charlotte, github: "LeakyBucket/charlotte" }
```

Once you have added and installed the dependency you are good to go.

There are a few different environment variables that Charlotte expects.  These can be set outside the application or defaults can be given to Charlotte.start/2

```elixir
  default_config = HashDict.new([
    {"CHARLOTTE_CONTROLLER_PATH", __DIR__ <> "/support/controllers"},
    {"CHARLOTTE_VIEW_PATH", __DIR__ <> "/support/views"},
    {"CHARLOTTE_ASSET_PATH", __DIR__ <> "/support/assets"},
    {"CHARLOTTE_HOST", "localhost"},
    {"CHARLOTTE_PROTOCOL", "tcp"},
    {"CHARLOTTE_ACCEPTORS", "100"},
    {"CHARLOTTE_COMPRESS", "false"},
    {"CHARLOTTE_PORT", "8000"}
  ])

  Charlotte.start [], [default_config: default_config]
``` -->

## Long How

  TODO