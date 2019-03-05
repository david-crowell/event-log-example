defmodule StatefulWeb.PageController do
  use StatefulWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
