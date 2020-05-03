defmodule BlogWeb.ScrapperView do
  use BlogWeb, :view

  def render("psplus.json", %{games: games}) do
    %{ free_games: render_many(games, __MODULE__, "game.json", as: :game) }
  end

  def render("game.json", %{game: game}) do
    %{
      name: game |> Floki.find("span") |> Enum.at(1) |> Floki.text,
      image: game |> Floki.find("img.product-image__img-main") |> Floki.attribute("src") |> Enum.at(0),
      url: game |> Floki.find("a") |> Enum.at(0) |> Floki.attribute("href") |> Enum.at(0),
      base_price: game |> Floki.find("h3.price-display__price") |> Floki.text,
    }
  end
end
