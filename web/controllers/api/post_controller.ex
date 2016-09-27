defmodule FromSpace.Api.PostController do
  use FromSpace.Web, :controller

  alias FromSpace.{Post}

  def index(conn, _) do
    posts = Post.published_by_creation
    render(FromSpace.PostController, "posts.json", posts: posts)
  end
end
