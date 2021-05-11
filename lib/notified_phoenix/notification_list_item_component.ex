defmodule NotifiedPhoenix.NotificationListItemComponent do
  use Phoenix.LiveComponent
  import Phoenix.HTML.Form

  @impl true
  def render(assigns) do
    notification = assigns.notification
    changeset = Notified.Notification.changeset(notification, %{})

    ~L"""
    <%= form_for changeset, "#", [id: notification.id], fn _f -> %>
      <div class="group py-4 hover:bg-gray-50 hover:bg-opacity-50 relative">
        <div>
          <h4 class="font-bold"><%= notification.subject %></h4>
          <div class="space-x-4">
            <span>created: <%= notification.inserted_at %></span>
            <span>seen: <%= notification.seen_at || "-" %></span>
          </div>
          <div>
            <span>tags:</span>
            <%= for tag <- notification.tags do %>
              <span class="bg-purple-300 rounded p-1 text-white inline-block">
                <%= tag %>
              </span>
            <% end %>
          </div>
        </div>
        <div class="mt-2 py-4 bg-gray-100 bg-opacity-25"><%= notification.message %></div>
        <button
          type="button"
          phx-click="delete-notification"
          phx-value-id="<%= notification.id %>"
          class="invisible group-hover:visible absolute top-4 right-4 text-red-500 hover:underline"
        >
          delete
        </button>
      </div>
    <% end %>
    """
  end
end
