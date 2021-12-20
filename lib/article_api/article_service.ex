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

  def update_article(id, %{"title" => title}) do
    # Get article by id
    {:ok, article} = get_one_article(id)
    # Update article
    updated_article = %{article | title: title}
    # Remove from Store
    Agent.update(Store, fn data ->
      Enum.filter(data, fn item ->
        item.id != String.to_integer(id)
      end)
    end)

    # Put back updated article
    Agent.update(Store, fn articles -> [updated_article | articles] end)
    {:ok, "Article updated."}
  end

  def remove_article(id) do
    Agent.update(Store, fn data ->
      Enum.filter(data, fn item -> item.id != String.to_integer(id) end)
    end)

    {:ok, "Article deleted."}
  end
end
