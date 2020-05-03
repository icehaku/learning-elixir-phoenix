defmodule BlogWeb.ScrapperController do
  use BlogWeb, :controller

  require IEx

  def psplus(conn, _params) do
    url = "https://store.playstation.com/en-us/grid/STORE-MSF77008-PSPLUSFREEGAMES/1"

    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, document} = Floki.parse_document(body)
          games =
            document |> Floki.find("div.grid-cell--game")
            {:ok, games}

            render(conn, "psplus.json", games: games)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        render(conn, "index.html", reason: "404")
      {:error, %HTTPoison.Error{reason: reason}} ->
        render(conn, "index.html", reason: reason)
    end
  end
end
