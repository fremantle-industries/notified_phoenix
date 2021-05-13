defmodule NotifiedPhoenixTest do
  use NotifiedPhoenix.ViewCase
  doctest NotifiedPhoenix

  describe ".render/2 badge.html" do
    test "displays the count of unread notifications" do
      html = render(NotifiedPhoenix, "badge.html", unseen: 5)

      assert assert_html(html, "span", text: "5")
    end
  end

  describe ".render/2 list.html" do
    test "displays the details of each notification" do
      notification_1 = insert(:notification, %{message: "Order has been created"})
      notification_2 = insert(:notification, %{message: "Order has been shipped"})
      items = [notification_1, notification_2]
      html = render(NotifiedPhoenix, "list.html", items: items)

      assert assert_html(html, "ul li:nth-child(1) h4", text: "Order has been created")
      assert assert_html(html, "ul li:nth-child(2) h4", text: "Order has been shipped")
    end
  end
end
