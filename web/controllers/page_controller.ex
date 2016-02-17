defmodule PlayChannel.PageController do
  use PlayChannel.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
