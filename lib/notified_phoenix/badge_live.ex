defmodule NotifiedPhoenix.BadgeLive do
  use Phoenix.LiveView
  import Phoenix.HTML.Link

  @default_class "border rounded-xl px-2 py-1 font-bold text-white bg-red-500 border-red-500"

  @impl true
  def mount(_params, _session, socket) do
    Phoenix.PubSub.subscribe(Notified.Config.pubsub_server(), Notified.Topic.create("*"))
    Phoenix.PubSub.subscribe(Notified.Config.pubsub_server(), Notified.Topic.mark_seen("*"))

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
    <%= link unseen, to: to(), class: class %>
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

  defp to do
    case NotifiedPhoenix.Config.to_list() do
      {mod, func, args} -> apply(mod, func, args)
      url -> url
    end
  end
end
