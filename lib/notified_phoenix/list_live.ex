defmodule NotifiedPhoenix.ListLive do
  use Phoenix.LiveView

  @default_class ""

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(Notified.Config.pubsub_server(), Notified.Topic.create("*"))

    socket =
      socket
      |> assign(:has_new_notifications, false)
      |> assign(:class, socket.assigns[:class] || @default_class)

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    socket =
      socket
      |> assign(:query, Map.get(params, "query"))
      |> assign_search()

    {:noreply, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h2 class="text-3xl">Notifications</h2>

      <div class="flex items-center mt-4 mb-4 space-x-4">
        <form phx-change="search">
          <input
            type="text"
            name="query"
            value={@query}
            placeholder="Search"
            autocomplete="off"
            class="bg-gray-100 opacity-25"
            disabled  />
          <button
            type="button"
            phx-click="clear-notifications"
            class="bg-red-500 text-white font-bold rounded p-2">
            clear
          </button>
        </form>
      </div>

      <%= if assigns.has_new_notifications do %>
        <div class="mb-2 p-4 border border-yellow-100 bg-yellow-50 text-yellow-500">
          There are new notifications - <button phx-click="load-notifications" class="underline">click to load</button>
        </div>
      <% end %>

      <%= if Enum.any?(assigns.notifications) do %>
        <%= for n <- assigns.notifications do %>
          <.live_component module={NotifiedPhoenix.NotificationListItemComponent} id={"notification-list-item-#{n.id}"} notification={n}) />
          <hr class="mx-4" />
        <% end %>
      <% else %>
        <div>There are no current notifications</div>
      <% end %>
    </div>
    """
  end

  @impl true
  def handle_event("load-notifications", _params, socket) do
    socket =
      socket
      |> assign_search()

    {:noreply, socket}
  end

  @impl true
  def handle_event("search", params, socket) do
    query = Map.get(params, "query")

    socket =
      socket
      |> assign(:query, query)
      |> assign_search()

    {:noreply, socket}
  end

  @impl true
  def handle_event("delete-notification", %{"id" => id}, socket) do
    id
    |> Notified.get!()
    |> Notified.delete()

    socket =
      socket
      |> assign_search()

    {:noreply, socket}
  end

  @impl true
  def handle_event("clear-notifications", _params, socket) do
    Notified.clear()

    socket =
      socket
      |> assign_search()

    {:noreply, socket}
  end

  @impl true
  def handle_info({:notified, :create, _notification_id}, socket) do
    socket =
      socket
      |> assign(:has_new_notifications, true)

    {:noreply, socket}
  end

  defp assign_search(socket) do
    notifications =
      socket.assigns.query
      |> Notified.search([])
      |> Enum.map(fn n ->
        if n.seen_at == nil do
          {:ok, n} = Notified.mark_seen(n)
          n
        else
          n
        end
      end)

    socket
    |> assign(:notifications, notifications)
    |> assign(:has_new_notifications, false)
  end
end
