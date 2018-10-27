defmodule ShangTsung.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    :ok = verify_node_name()

    ensure_tsung_dirs()

    children = [
      # supervisor(ShangTsung.Repo, []),

      supervisor(ShangTsungWeb.Endpoint, []),
      ShangTsung.Monitor
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

  ### Internal Functions

  defp verify_node_name do
    name =
      node()
      |> Atom.to_string
      |> String.split("@")
      |> hd

    case name do
      "tsung_control" <> _ -> :ok
      _ -> raise "invalid node name: #{name}"
    end
  end

  defp ensure_tsung_dirs do
    File.mkdir_p!(Application.get_env(:shang_tsung, :tsung_config_dir))
    File.mkdir_p!(Application.get_env(:shang_tsung, :tsung_log_dir))
  end
end
