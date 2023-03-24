defmodule ExSnakeWeb.PageControllerTest do
  use ExSnakeWeb.ConnCase

  test "GET /ready", %{conn: conn} do
    conn = get(conn, ~p"/ready")
    assert conn.resp_body =~ "OK"
  end

  test "GET /health", %{conn: conn} do
    conn = get(conn, ~p"/health")
    assert conn.resp_body =~ "OK"
  end
end
