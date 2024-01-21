defmodule WebAppWeb.PageLive.Index do
  use WebAppWeb, :live_view

  import Phoenix.HTML.Form

  def mount(_params, _session, socket) do
    form = %{}
    {
      :ok,
      socket
      |> save(form)
      |> validate(form)
    }
  end

  def handle_params(_params, _url, socket) do
    {:noreply, socket}
  end

  def validate(socket, attrs) do
    assign(socket, changeset: WebAppWeb.FormData.validate(attrs))
  end

  def save(socket, form) do
    IO.inspect(form, label: "FORM >>>>>>> ")
    assign(socket, form_data: form)
  end

  def render(assigns) do
    ~H"""
    <section class="mt-24 w-1/2 shadow flex flex-col items-left mx-auto p-6 bg-white">
      <h1 class="text-4xl font-bold italic text-gray-700">
        Create Account
      </h1>
      <p class="text-gray-500 font-semibold text-lg mt-6 mb-6 text-left px-8">
        Sign up to get an account
      </p>
      <%= form_for @changeset, "#", [as: :user, phx_change: :validate, phx_submit: :save], fn f -> %>
        <%= label f, :username %>
        <%= text_input f, :username %>
        <%!-- <%= error_tag f, :username %> --%>

        <br><br>
        <%= label f, :password %>
        <%= password_input f, :password %>
        <%!-- <%= error_tag f, :password %> --%>

        <br><br>
        <%= label f, :role %>
        <%= select f, :role,  [buyer: :buyer, seller: :seller] %>
        <%!-- <%= error_tag f, :role %> --%>

        <br><br>
        <%= submit "Submit",
          class: "bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded",
          disabled: !@changeset.valid?
        %>
      <% end %>
    </section>
    """
  end

  def handle_event("validate", %{"user" => form}, socket) do
    {:noreply, validate(socket, form)}
  end

  def handle_event("save", %{"user" => form}, socket) do
    {:noreply, save(socket, form)}
  end
end
