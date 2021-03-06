defmodule Rumbl.SessionController do
  use Rumbl.Web, :controller
  alias Rumbl.User

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => username, "password" => password}}) do
    case Rumbl.Auth.login_by_username_and_pass(conn, username, password, repo: Rumbl.Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "logged in")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn } ->
        conn
        |> put_flash(:error, "cannot login")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Rumbl.Auth.logout
    |> redirect(to: page_path(conn, :index))
  end
end
