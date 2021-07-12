defmodule ArticleApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    port = 4000

    children = [
      # Starts a worker by calling: ArticleApi.Worker.start_link(arg)
      # {ArticleApi.Worker, arg}

      {Plug.Cowboy, scheme: :http, plug: Routes, options: [port: port]},
      {ArticleApi.ArticleService, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ArticleApi.Supervisor]
    Logger.info("The server has started at port: #{port}...")
    Supervisor.start_link(children, opts)
  end
end
