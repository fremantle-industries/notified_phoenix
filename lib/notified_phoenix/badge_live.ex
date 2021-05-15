defmodule NotifiedPhoenix.BadgeLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Link

  alias Notified.{Config, Topic}

  @default_class "border rounded-xl px-2 py-1 font-bold text-white bg-red-500 border-red-500"

  @impl true
  def mount(_params, _session, socket) do
    pubsub_server = Config.pubsub_server()
    Phoenix.PubSub.subscribe(pubsub_server, Topic.create("*"))
    Phoenix.PubSub.subscribe(pubsub_server, Topic.mark_seen("*"))
    Phoenix.PubSub.subscribe(pubsub_server, Topic.receiver_sent("*"))

    socket =
      socket
      |> assign(:unseen, Notified.count_unseen())
      |> assign(:class, socket.assigns[:class] || @default_class)

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    unseen = if assigns.unseen > 10, do: "10+", else: assigns.unseen
    class = if assigns.unseen == 0, do: "opacity-50 #{assigns.class}", else: assigns.class

    ~L"""
    <div id="notified-phoenix-badge" phx-hook="NotifiedPhoenix">
      <%= link unseen, to: to(), class: class %>
    </div>
    """
  end

  @impl true
  def handle_info({:notified, action, _notification_id}, socket)
      when action in [:create, :mark_seen] do
    socket =
      socket
      |> assign(:unseen, Notified.count_unseen())

    {:noreply, socket}
  end

  @impl true
  def handle_info({:notified, :receiver_sent, receiver_and_notification}, socket) do
    case receiver_and_notification do
      {%NotifiedPhoenix.Receivers.Speech{}, notification} ->
        event = "notified_phoenix:receiver_sent:speech"
        payload = %{subject: notification.subject}
        socket = push_event(socket, event, payload)
        {:noreply, socket}

      {%NotifiedPhoenix.Receivers.BrowserNotification{}, notification} ->
        event = "notified_phoenix:receiver_sent:browser_notification"

        payload = %{
          subject: notification.subject,
          message: notification.message,
          tags: notification.tags
        }

        socket = push_event(socket, event, payload)
        {:noreply, socket}

      _ ->
        {:noreply, socket}
    end
  end

  defp to do
    case NotifiedPhoenix.Config.to_list() do
      {mod, func, args} -> apply(mod, func, args)
      url -> url
    end
  end
end
