defmodule ExSnakeWeb.PageLive do
  use ExSnakeWeb, :live_view

  alias ExSnakeWeb.Components.{Grid, Footer}

  require Logger

  @default_columns 21
  @default_rows 21

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       user: "",
       points: 0,
       columns: @default_columns,
       rows: @default_rows,
       user_map: "{}"
     )}
  end

  @impl true
  def handle_event("move_update", %{"key" => "ArrowUp"}, socket) do
    ExSnake.GameSm.action(socket.assigns.user, :up)
    {:noreply, socket}
  end

  @impl true
  def handle_event("move_update", %{"key" => "ArrowDown"}, socket) do
    ExSnake.GameSm.action(socket.assigns.user, :down)
    {:noreply, socket}
  end

  @impl true
  def handle_event("move_update", %{"key" => "ArrowLeft"}, socket) do
    ExSnake.GameSm.action(socket.assigns.user, :left)
    {:noreply, socket}
  end

  @impl true
  def handle_event("move_update", %{"key" => "ArrowRight"}, socket) do
    ExSnake.GameSm.action(socket.assigns.user, :right)
    {:noreply, socket}
  end

  @impl true
  def handle_event("move_update", %{"key" => key}, socket) do
    Logger.warning("Invalid or not expected key typed: #{key}")
    {:noreply, socket}
  end

  @impl true
  def handle_info({:snake_sm_updated, user, snake_position, points, {fx, fy}}, socket) do
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

    {:noreply, assign(socket, user_map: user_map, points: points, user: user)}
  end

  @impl true
  def handle_info({:snake_sm_game_over, data}, socket) do
    Logger.info("Received snake_sm_game_over with map: #{inspect(data)}")

    with {:ok, [{player_username, player_score} | _]} <-
           ExSnake.Storage.Game.get_best_player(ExSnake.GameSm),
         true <- data.points >= player_score,
         true <- data.username == player_username do
      {:noreply,
       socket |> put_flash(:info, "Game Over - New Record \n congrats #{data.points} points")}
    else
      _ ->
        {:noreply, socket |> put_flash(:error, "Game Over - Sorry, try again")}
    end
  end
end
