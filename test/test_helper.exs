default_config = HashDict.new() |>
  HashDict.put("CHARLOTTE_CONTROLLER_PATH", __DIR__ <> "/support/controllers") |>
  HashDict.put("CHARLOTTE_VIEW_PATH", __DIR__ <> "/support/views") |>
  HashDict.put("CHARLOTTE_ASSET_PATH", __DIR__ <> "/support/assets") |>
  HashDict.put("CHARLOTTE_HOST", "localhost") |>
  HashDict.put("CHARLOTTE_PROTOCOL", "tcp") |>
  HashDict.put("CHARLOTTE_ACCEPTORS", "100") |>
  HashDict.put("CHARLOTTE_COMPRESS", "false") |>
  HashDict.put("CHARLOTTE_PORT", "8000")


Charlotte.start([], [default_config: default_config])

ExUnit.start
