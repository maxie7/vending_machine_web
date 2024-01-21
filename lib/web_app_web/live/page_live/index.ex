defmodule WebAppWeb.PageLive.Index do
  use WebAppWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>LIVE VIEWWWWWWW</div>
    """
  end
end
