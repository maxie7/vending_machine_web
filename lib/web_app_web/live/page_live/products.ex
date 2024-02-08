defmodule WebAppWeb.PageLive.Products do
  use WebAppWeb, :live_view

  # import Phoenix.HTML.Form

  alias WebAppWeb.Api.Client

  def handle_params(_params, _session, socket) do
    new_socket =
      socket
      |> assign(products: [])
      |> push_event("restore", %{key: "cookie", event: "restoreSettings"})

    {:noreply, new_socket}
  end

  def handle_event("restoreSettings", nil, socket) do
    {:noreply, socket |> push_redirect(to: "/login") }
  end

  def handle_event("restoreSettings", params, socket) do
    case Client.get_products(params) do
      {:ok, {:ok, %{"data" => products}}} ->
        {:noreply, assign(socket, products: products)}
      _ ->
        {:noreply, socket |> push_redirect(to: "/login")}
    end
  end

  def render(assigns) do
    ~H"""
    <section
      class="mt-12 w-1/2 shadow flex flex-col items-left mx-auto p-6 bg-white"
      id="vending-machine"
      phx-hook="LocalStateStore"
    >
      <h1 class="text-4xl font-bold text-gray-700">
        Vending Machine
      </h1>
      <p class="text-gray-500 font-semibold text-lg mt-6 mb-6 text-left">
        List of Products to Buy
      </p>
        <%= if @products != [] do %>
        <div>
          <table class="table-auto">
            <thead>
              <tr>
                <th>Product</th>
                <th>Cost</th>
                <th>Available Amount</th>
              </tr>
            </thead>
            <tbody>
              <%= for product <- @products do %>
                <tr>
                  <td><%= product["product_name"] %></td>
                  <td><%= product["cost"] %></td>
                  <td><%= product["amount_available"] %></td>
                </tr>
              <% end %>
            </tbody>
          </table>
        </div>
        <% end %>
    </section>
    """
  end
end
