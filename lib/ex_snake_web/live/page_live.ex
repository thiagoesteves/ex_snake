defmodule ExSnakeWeb.PageLive do
  use ExSnakeWeb, :live_view

  require Logger

  @default_columns 21
  @default_rows 21

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, columns: @default_columns, rows: @default_rows, user_map: "{}")}
  end

  @impl true
  def handle_event("move_update", %{"key" => "ArrowUp"}, socket) do
    ExSnake.GameSm.action("thiagoesteves", :up)
    {:noreply, socket}
  end

  @impl true
  def handle_event("move_update", %{"key" => "ArrowDown"}, socket) do
    ExSnake.GameSm.action("thiagoesteves", :down)
    {:noreply, socket}
  end

  @impl true
  def handle_event("move_update", %{"key" => "ArrowLeft"}, socket) do
    ExSnake.GameSm.action("thiagoesteves", :left)
    {:noreply, socket}
  end

  @impl true
  def handle_event("move_update", %{"key" => "ArrowRight"}, socket) do
    ExSnake.GameSm.action("thiagoesteves", :right)
    {:noreply, socket}
  end

  @impl true
  def handle_info({:snake_sm_updated, snake_position, points, {fx, fy}}, socket) do
    Logger.info(
      "Received snake_position: #{inspect(snake_position)} points: #{points} food: {#{fx}, #{fy}}"
    )

    user_map =
      snake_position
      |> List.foldl(
        %{counter: 0, snake: []},
        fn {x, y}, %{counter: acc, snake: snake} ->
          %{
            counter: acc + 1,
            snake: snake ++ [%{x: x, y: y}]
          }
        end
      )
      |> Map.delete(:counter)
      |> Map.put(:update, :elisnake_sm)
      |> Map.put(:food, %{x: fx, y: fy})
      |> Map.put(:points, points)
      |> Jason.encode!()

    send_update(ExSnakeWeb.Components.Grid,
      id: "grid",
      columns: socket.assigns.columns,
      rows: socket.assigns.rows,
      user_map: user_map
    )

    {:noreply, assign(socket, user_map: user_map)}
  end

  @impl true
  def handle_info({:snake_sm_game_over, map}, socket) do
    Logger.info("Received snake_sm_game_over with map: #{inspect(map)}")
    {:noreply, socket}
  end
end
