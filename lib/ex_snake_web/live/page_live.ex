defmodule ExSnakeWeb.PageLive do
  use ExSnakeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, user_map: "{}")}
  end

  @impl true
  def handle_info({:snake_sm_updated, snake_position, points, {fx, fy}}, socket) do
    IO.puts(
      "Received snake_position: #{inspect(snake_position)} points: #{points} food: {#{fx}, #{fy}}"
    )

    user_map =
      snake_position
      |> List.foldl(
        %{counter: 0, snake: %{}},
        fn {x, y}, %{counter: acc, snake: snake} ->
          %{
            counter: acc + 1,
            snake: snake |> Map.put("p" <> to_string(acc), %{x: x, y: y})
          }
        end
      )
      |> Map.delete(:counter)
      |> Map.put(:update, :elisnake_sm)
      |> Map.put(:food, %{x: fx, y: fy})
      |> Map.put(:points, points)
      |> Jason.encode!()

    {:noreply, assign(socket, user_map: user_map)}
  end
end
