defmodule InitialsImage do
  @default_settings %{path: "./", size: 300, background_color: {76, 80, 238}, text_color: {255, 255, 255}, font: File.cwd! <> "/lib/fonts/OpenSans-Regular.ttf"}

  alias InitialsImage.Image

  def run(name, options \\ %{}) when is_binary(name) do
    options
    |> build_image
    |> build_initials(name)
    |> draw_image(name)
  end

  ####################### PRIVATE #######################

  defp build_image(options) do
    options = @default_settings |> Map.merge(options)
    font_size = (options.size * 2 / 3) * 72 / 96 # points

    %Image{size: options.size, background_color: options.background_color, text_color: options.text_color, path: options.path, font: options.font, font_size: font_size}
  end

  defp build_initials(image, name) do
    [first_name | tail] = name
      |> String.replace(~r/ +/, " ")
      |> String.split(" ", parts: 2)

    last_name = tail |> Enum.join(" ")
    short = [
      String.at(first_name, 0) |> String.Chars.to_string,
      String.at(last_name, 0) |> String.Chars.to_string
    ] |> Enum.join("") |> String.upcase

    %Image{image | initials: {first_name, last_name, short}}
  end

  defp draw_image(%Image{size: size, font_size: font_size, background_color: background_color, initials: {_first_name, _last_name, short}, text_color: text_color, font: font, path: path}, name) do
    {br,bg,bb} = background_color
    {tr,tg,tb} = text_color
    full_path = "#{path}#{name}.png"

    System.cmd "convert", [
      "-background", "rgb(#{br},#{bg},#{bb})",
      "-fill", "rgb(#{tr},#{tg},#{tb})",
      "-font", "#{font}",
      "-size", "#{size}x#{size}",
      "-pointsize", "#{font_size}",
      "-gravity", "center",
      "caption:#{short}", "#{full_path}"
    ]

    full_path
  end
end
