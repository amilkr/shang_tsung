defmodule ShangTsung.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    ensure_tsung_dirs()

    children = [
      # supervisor(ShangTsung.Repo, []),
      supervisor(ShangTsungWeb.Endpoint, []),
      supervisor(Task.Supervisor, [[name: :monitor_sup]])
    ]

    opts = [strategy: :one_for_one, name: ShangTsung.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ShangTsungWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp ensure_tsung_dirs do
    File.mkdir_p!(Application.get_env(:shang_tsung, :tsung_config_dir))
    File.mkdir_p!(Application.get_env(:shang_tsung, :tsung_log_dir))
  end
end
