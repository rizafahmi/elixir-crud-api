defmodule ArticleApi.ArticleService do
  use Agent
  alias ArticleApi.ArticleService.Article

  def start_link(_) do
    Agent.start_link(fn -> [] end, name: Store)
  end

  def get_all_articles() do
    articles = Agent.get(Store, fn data -> data end)
    IO.inspect(articles)
    {:ok, articles}
  end

  def get_one_article(id) do
    IO.inspect(id)

    article =
      Agent.get(Store, fn data ->
        Enum.find(data, fn item -> item.id == String.to_integer(id) end)
      end)

    {:ok, article}
  end

  def add_article(%{"id" => id, "title" => title, "excerpt" => excerpt, "body" => body}) do
    article = %Article{id: id, title: title, excerpt: excerpt, body: body}
    Agent.update(Store, fn articles -> [article | articles] end)
    {:ok, "Article created."}
  end
end
