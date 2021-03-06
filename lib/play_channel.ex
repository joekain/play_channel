defmodule PlayChannel do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(PlayChannel.Endpoint, []),
      # Start the Ecto repository
      supervisor(PlayChannel.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(PlayChannel.Worker, [arg1, arg2, arg3]),
      PlayChannel.Toy.EventManager.child_spec
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PlayChannel.Supervisor]

    with {:ok, pid} <- Supervisor.start_link(children, opts),
         :ok <- PlayChannel.Toy.UpdateEventHandler.register_with_manager,
      do: {:ok, pid}
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PlayChannel.Endpoint.config_change(changed, removed)
    :ok
  end
end
