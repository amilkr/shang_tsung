defmodule ShangTsungWeb.PageControllerTest do
  use ShangTsungWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "start the Load Test"
  end
end
