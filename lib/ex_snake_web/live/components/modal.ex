defmodule ExSnakeWeb.Components.Modal do
  use ExSnakeWeb, :live_component

  @impl true
  def mount(socket) do
    IO.puts("starting")
    {:ok, assign(socket, state: "CLOSED")}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id} class="bg-orange-100 border-l-4 border-orange-500 text-orange-700 p-4" role="alert">
      <p class="font-bold">Be Warned: I'm currently <%= @state %></p>
    </div>
    """
  end

  @impl true
  def handle_event("click", _, socket) do
    _ = socket.assigns.on_click.()
    {:noreply, socket}
  end

  @impl true
  def handle_event("open", _, socket) do
    user = "thiagoesteves"

    case ExSnake.GameSm.Sup.create_game(user, {20, 20}, 200) do
      {:ok, _} -> :none
      {:error, {:already_started, _}} -> :none
    end

    {:ok, _} = ExSnake.GameSm.start_game(user)

    {:noreply, assign(socket, :state, "OPEN")}
  end
end
