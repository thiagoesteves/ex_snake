defmodule ExSnakeWeb.Components.Footer do
  use ExSnakeWeb, :live_component

  @impl true
  def render(assigns) do
    ~H"""
    <footer class="bg-white border-gray-200 px-4 lg:px-6 py-2.5 dark:bg-gray-800">
      <div class="w-full mx-auto container md:p-6 p-4 md:flex md:items-center md:justify-between">
        <span class="text-sm text-gray-500 sm:text-center dark:text-gray-400">
          © 2023 <a href="http://www.calori.com.br/" class="hover:underline">Calori Software</a>. All Rights Reserved.
        </span>
      </div>
    </footer>
    """
  end
end
