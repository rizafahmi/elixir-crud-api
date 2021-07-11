defmodule ArticleApiTest do
  use ExUnit.Case
  doctest ArticleApi

  test "greets the world" do
    assert ArticleApi.hello() == :world
  end
end
