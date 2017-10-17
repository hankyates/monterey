defmodule Monterey.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/surveys" do
    send_resp(
      conn,
      200,
      Monterey.Surveys.get_surveys(conn)
    )
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
