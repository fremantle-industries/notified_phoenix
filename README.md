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

### Live Badge

```elixir
<%= live_render(@socket, NotifiedPhoenix.BadgeLive, [] %>
```

![badge](./docs/badge.png)

### Live List

```elixir
<%= live_render(@socket, NotifiedPhoenix.ListLive, class: "my-custom-style" %>
```

![list](./docs/list.png)

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`notified_phoenix` is released under the [MIT license](./LICENSE)
