defmodule FromSpace.AuthController do
  use FromSpace.Web, :controller
  alias FromSpace.Admin
  alias FromSpace.AuthService

  def new(conn, _params) do
    changeset = Admin.changeset(%Admin{})
    render conn, "new.html", changeset: changeset
  end

  def register(conn, %{"admin" => admin_params}) do
    changeset = Admin.changeset(%Admin{}, admin_params)
    case AuthService.create(changeset) do
      {:ok, admin} ->
        conn
        |> put_session(:admin, admin.id)
        |> put_flash(:info, "Admin created")
        |> redirect(to: "/admin/dashboard")
      :else ->
        conn
        |> put_flash(:error, "Please try again")
        |> redirect(to: "/new")
    end
  end

  def auth(conn, _params) do
    changeset = Admin.changeset(%Admin{})
    render conn, "auth.html", changeset: changeset
  end

  def login(conn, %{"admin" => admin_params}) do
    changeset = cast(%Admin{}, admin_params, ~w(password), ~w())
    case AuthService.login do
      nil ->
        conn
        |> put_flash(:error, "No admins registered")
        |> redirect(to: "/admin")
      admin ->
        conn
        |> put_session(:admin, admin.id)
        |> redirect(to: "/admin/dashboard")    
    end
  end
end