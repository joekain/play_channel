ExUnit.start

Mix.Task.run "ecto.create", ~w(-r PlayChannel.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r PlayChannel.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(PlayChannel.Repo)

