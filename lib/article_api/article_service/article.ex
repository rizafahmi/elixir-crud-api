defmodule ArticleApi.ArticleService.Article do
  @derive Jason.Encoder
  defstruct [:id, :title, :excerpt, :body]
end
