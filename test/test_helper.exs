Amrita.start

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

Charlotte.start([], [default_config: default_config])