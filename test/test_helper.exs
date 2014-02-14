Amrita.start

default_config = HashDict.new([
  {"CHARLOTTE_CONTROLLER_PATH", __DIR__ <> "/controllers"},
  {"CHARLOTTE_VIEW_PATH", __DIR__ <> "/views"},
  {"CHARLOTTE_HOST", "localhost"},
  {"CHARLOTTE_PROTOCOL", "tcp"},
  {"CHARLOTTE_ACCEPTORS", "100"},
  {"CHARLOTTE_COMPRESS", "false"},
  {"CHARLOTTE_PORT", "8000"}
])

# System.put_env("CHARLOTTE_CONTROLLER_PATH", __DIR__ <> "/controllers")
# System.put_env("CHARLOTTE_VIEW_PATH", __DIR__ <> "/views")
# System.put_env("CHARLOTTE_HOST", "localhost")
# System.put_env("CHARLOTTE_PROTOCOL", "tcp")
# System.put_env("CHARLOTTE_ACCEPTORS", "100")
# System.put_env("CHARLOTTE_COMPRESS", "false")
# System.put_env("CHARLOTTE_PORT", "8000")

Charlotte.start([], [default_config: default_config])