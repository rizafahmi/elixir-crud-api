defmodule Routes do
  use Plug.Router

  alias ArticleApi.ArticleService

  plug(:match)

  # We want the response to be sent in json format.
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)

  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, Jason.encode!(%{"status" => "OK"}))
  end

  get "/all" do
    response = ArticleService.get_all_articles()
    handle_response(response, conn)
  end

  post "/new" do
    response = ArticleService.add_article(conn.body_params)
    handle_response(response, conn)
  end

  get "/details/:id" do
    response = ArticleService.get_one_article(id)
    handle_response(response, conn)
  end

  defp handle_response(response, conn) do
    %{code: code, message: message} =
      case response do
        {:ok, message} -> %{code: 200, message: Jason.encode!(message)}
        {:not_found, message} -> %{code: 404, message: message}
        {:malformed_data, message} -> %{code: 400, message: message}
        {:server_error, _message} -> %{code: 500, message: "An error occured internally"}
      end

    send_resp(conn, code, message)
  end
end
