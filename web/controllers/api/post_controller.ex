defmodule FromSpace.Api.PostController do
  use FromSpace.Web, :controller

  alias FromSpace.{Post}

  def index(conn, _) do
    posts = Post.published_by_creation
    render(conn, FromSpace.PostView, "posts.json", posts: posts)
  end

  def show(conn, %{"url" => url}) do
    post = Repo.get_by(Post, url: url)
    case post do
      nil -> render(conn, FromSpace.PostView, "no-post.json")
      %Post{} -> render(conn, FromSpace.PostView, "post.json", post: post)
    end
  end
end
