defmodule Routes do
  use Plug.Router

  # alias ArticleApi.ArticleService

  plug(:match)

  # We want the response to be sent in json format.
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)

  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, Jason.encode!(%{"status" => "OK"}))
  end
end
