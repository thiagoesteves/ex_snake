defmodule ExSnakeWeb.Health.Plug do
    import Plug.Conn
  
    @behaviour Plug
  
    @path_startup   "/health"
    @path_readiness "/ready"
  
    @impl true
    def init(opts), do: opts
  
    @impl true
    def call(%Plug.Conn{} = conn, _opts) do
      case conn.request_path do
        @path_startup   -> health_response(conn, true)
        @path_readiness -> health_response(conn, true)
        _other          -> conn
      end
    end
  
    defp health_response(conn, true) do
      conn
      |> send_resp(200, "OK")
      |> halt()
    end
  end