defmodule ExSnakeWeb.Components.Grid do
  use ExSnakeWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <div class="board-game" style="background-color:#F8EDED;">
      <div class="game">
        <%!-- <div style="background-color: #E4BAD4; color: #AC66CC;"></div> --%>
        <%!-- <div style="background-color: lightblue;"> </div> --%>
        <%!-- <div> </div> --%>
        <%= for _columns <- 1..@columns do %>
          <%= for _rows <- 1..@rows do %>
            <div class="bg-red-500 shadow-xl min-h-[20px]" />
          <% end %>
        <% end %>
      </div>
    </div>
    """
  end
end
