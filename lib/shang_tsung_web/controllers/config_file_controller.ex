defmodule ShangTsungWeb.ConfigFileController do
  use ShangTsungWeb, :controller

  def create(conn, %{"file" => file}) do
    config_dir = Application.get_env(:shang_tsung, :tsung_config_dir)
    File.cp(file.path, config_dir <> file.filename)

    conn
    |> put_flash(:info, "Your config was uploaded successfully!")
    |> redirect(to: "/")
  end
end
