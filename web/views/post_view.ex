defmodule FromSpace.PostView do
  use FromSpace.Web, :view
  alias FromSpace.AuthService

  def render("no-post.json", _), do: %{error: "No posts match the given url"}
  
  def render("posts.json", %{posts: posts}) do
    %{posts: render_many(posts, FromSpace.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{
      title: post.title,
      url: post.url,
      previewImage: post.preview_image,
      previewText: post.preview_text,
      tags: post.tags,
      insertedAt: post.inserted_at,
      html: post.html
    }
  end
end
