defmodule Algorithms.PageController do
  use Algorithms.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
