defmodule ShangTsung do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    ensure_tsung_dirs()

    children = [
      # Start the endpoint when the application starts
      supervisor(ShangTsung.Endpoint, []),
      # Start the Ecto repository
      worker(ShangTsung.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(ShangTsung.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ShangTsung.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ShangTsung.Endpoint.config_change(changed, removed)
    :ok
  end

  def ensure_tsung_dirs do
    File.mkdir_p!(Application.get_env(:shang_tsung, :tsung_config_dir))
    File.mkdir_p!(Application.get_env(:shang_tsung, :tsung_log_dir))
  end
  
end
