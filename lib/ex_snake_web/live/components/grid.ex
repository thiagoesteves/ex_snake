defmodule ExSnakeWeb.Components.Grid do
  use ExSnakeWeb, :live_component

  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <div class="board-game" style="background-color:#F8EDED;">
      <div class="game">
        <%!-- <div style="background-color: #E4BAD4; color: #AC66CC;"></div> --%>
        <%!-- <div style="background-color: lightblue;"> </div> --%>
        <%!-- <div> </div> --%>
        <%= with m <- @user_map |> Jason.decode!() do %>
          <%= for row <- @rows-1..0 do %>
            <%= for column <- 0..@columns-1 do %>
              <%= cond do %>
                <% m == %{} -> %>
                  <div class="bg-red-500 shadow-xl min-h-[20px]" />
                <% m["food"]["x"] == column and m["food"]["y"] == row -> %>
                  <div style="background-color: #E4BAD4; color: #AC66CC;"></div>
                <% true -> %>
                  <div style="background-color: lightblue;"></div>
              <% end %>
            <% end %>
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end
end
