# InitialsImage

Build initials avatars based on full user name.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `initials_image` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:initials_image, "~> 0.1.0"}
  ]
end
```

## Usage

```elixir

InitialsImage.run("Dohn Doe")
InitialsImage.run("Dohn Doe", %{ path: "./", size: 300, background_color: {76, 80, 238}, text_color: {255, 255, 255}, font: "/path/to/font.ttf" })

```

