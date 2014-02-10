Amrita.start

System.put_env("CHARLOTTE_CONTROLLER_PATH", __DIR__ <> "/controllers")
System.put_env("CHARLOTTE_HOST", "localhost")
System.put_env("CHARLOTTE_PROTOCOL", "tcp")
System.put_env("CHARLOTTE_ACCEPTORS", "100")
System.put_env("CHARLOTTE_COMPRESS", "false")
System.put_env("CHARLOTTE_PORT", "8000")

Charlotte.start([], [])