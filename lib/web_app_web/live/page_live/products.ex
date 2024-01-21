defmodule WebAppWeb.PageLive.Products do
  use WebAppWeb, :live_view

  # import Phoenix.HTML.Form

  alias WebAppWeb.Api.Client

  def mount(_params, session, socket) do
    IO.inspect session, label: "session >>>>>>>>>>>>>>>>>>>"
    IO.inspect socket, label: "socket >>>>>>>>>>>>>>>>>>>"
    Client.get_products()
    { :ok, socket}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def validate(socket, attrs) do
    assign(socket, changeset: WebAppWeb.FormData.validate(attrs))
  end

  def render(assigns) do
    ~H"""
    <section class="mt-12 w-1/2 shadow flex flex-col items-left mx-auto p-6 bg-white">
      <h1 class="text-4xl font-bold italic text-gray-700">
        Vending Machine
      </h1>
      <p class="text-gray-500 font-semibold text-lg mt-6 mb-6 text-left">
        List of Products to Buy
      </p>
    </section>
    """
  end

  def handle_event("validate", %{"user" => form}, socket) do
    {:noreply, validate(socket, form)}
  end

  def handle_event("save", %{"user" => _form}, socket) do
    # Client.sign_in(form)

    {:noreply, socket}
  end
end
