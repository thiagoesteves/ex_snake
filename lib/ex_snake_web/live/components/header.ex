defmodule ExSnakeWeb.Components.Header do
  use ExSnakeWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <header>
      <nav class="bg-white border-gray-200 px-4 lg:px-6 py-2.5 dark:bg-gray-800 mt-1">
        <div class="flex flex-wrap justify-between items-center mx-auto max-w-screen-xl">
          <div class="bg-transparent hover:bg-green-500 text-green-700 font-semibold hover:text-white py-2 px-4 border border-green-500 hover:border-transparent rounded">
            <%= case get_best_player() do %>
              <% {player_name, player_score} -> %>
                BEST - <%= player_name %>: <%= player_score %> POINTS
              <% _-> %>
                BE THE FIRST PLAYER
            <% end %>
          </div>

          <div class="flex items-center lg:order-2">
            <%= if @user_map == "{}" do %>
              <form phx-submit="assign_player" phx-target="#modal-one">
                <div class="relative">
                  <input
                    type="text"
                    name="user"
                    id="user-name"
                    class="block w-full p-3 pl-5 text-sm text-gray-900 border border-gray-300 rounded-lg bg-gray-50 focus:ring-blue-500 focus:border-blue-500 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500"
                    placeholder="User Name"
                    required
                  />
                  <button
                    type="submit"
                    class="text-white absolute right-2.5 bottom-2.5 bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-1 dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800"
                  >
                    Play
                  </button>
                </div>
              </form>
            <% else %>
              <div
                class="bg-transparent hover:bg-blue-500 text-blue-700 font-semibold hover:text-white py-2 px-4 border border-blue-500 hover:border-transparent rounded"
                style="min-width: 200px;"
              >
                <%= @user %>: <%= @points %>
              </div>
            <% end %>
          </div>
        </div>
      </nav>
    </header>
    """
  end

  defp get_best_player() do
    case ExSnake.Storage.Game.get_best_player(ExSnake.GameSm) do
      {:ok, []} -> nil
      {:ok, [{player_name, player_score} | _]} -> {player_name, player_score}
    end
  end
end
