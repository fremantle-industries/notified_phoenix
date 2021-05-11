# NotifiedPhoenix
[![Build Status](https://github.com/fremantle-industries/notified_phoenix/workflows/test/badge.svg?branch=main)](https://github.com/fremantle-industries/notified_phoenix/actions?query=workflow%3Atest)
[![hex.pm version](https://img.shields.io/hexpm/v/notified_phoenix.svg?style=flat)](https://hex.pm/packages/notified_phoenix)

Phoenix live views for [notified](https://github.com/fremantle-industries/notified)

## Installation

Add the `notified_phoenix` package to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:notified_phoenix, "~> 0.0.1"}
  ]
end
```

## Usage

![badge](./docs/badge.png)

```elixir
<%= live_render(@socket, NotifiedPhoenix.BadgeLive, [] %>
```

![list](./docs/list.png)

```elixir
notification_1 = %Notified.Notification{message: "Order has been created", seen_at: DateTime.utc_now(), seen: true}
notification_2 = %Notified.Notification{message: "Order has been shipped", seen_at: DateTime.utc_now(), seen: true}
notification_3 = %Notified.Notification{message: "Order has been delivered", seen_at: nil, seen: false}
items = [notification_1, notification_2, notification_3]

<%= live_render(@socket, NotifiedPhoenix.ListLive, class: "my-custom-style" %>
```

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`notified_phoenix` is released under the [MIT license](./LICENSE)
