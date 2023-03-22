defmodule ExSnakeWeb.Components.Modal do
  use ExSnakeWeb, :live_component

  require Logger

  @impl true
  def mount(socket) do
    {:ok, assign(socket, user: "")}
  end

  # This update add the parent static values to the live component
  @impl true
  def update(assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div id={@id}>
      <%= if @user == "" do %>
        <div
          class="bg-teal-100 border-t-4 border-teal-500 rounded-b text-teal-900 px-4 py-3 shadow-md"
          role="alert"
        >
          <div class="flex">
            <div class="py-1">
              <svg
                class="fill-current h-6 w-6 text-teal-500 mr-4"
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 20 20"
              >
                <path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z" />
              </svg>
            </div>
            <div>
              <p class="font-bold">Press Play to start the game</p>
            </div>
          </div>
        </div>
      <% else %>
        <div class="bg-orange-100 border-l-4 border-orange-500 text-orange-700 p-4" role="alert">
          <p class="font-bold"><%= @user %>, move using the arrows to play the game!</p>
        </div>
      <% end %>
    </div>
    """
  end

  @impl true
  def handle_event("assign_player", %{"user" => user}, socket) do
    # The game expects the range from 0->N
    case ExSnake.GameSm.Sup.create_game(
           user,
           {socket.assigns.rows - 1, socket.assigns.columns - 1},
           200
         ) do
      {:ok, _} -> :none
      {:error, {:already_started, _}} -> :none
    end

    {:ok, _} = ExSnake.GameSm.start_game(user)

    {:noreply, assign(socket, state: "OPEN", user: user)}
  end
end
