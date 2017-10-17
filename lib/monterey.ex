defmodule Monterey.Surveys do
  def parse_body(body) do
    get_in(body, ["hits", "hits"])
      |> Enum.map(fn hit -> hit["_source"] end)
  end
  def get_surveys(_conn) do
    IO.inspect(System.get_env("ES_AUTH"))
    headers = [
      "Authorization": "Basic #{System.get_env("ES_AUTH")}",
      "Accept": "application/json"
    ]
    case HTTPoison.post(
      'https://crdb-1096007071.us-east-1.bonsaisearch.net/test_brfss/_search',
      Poison.encode!(%{
        :query => %{
          :match_all => Map.new()
        }
      }),
      headers
    ) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body) |> parse_body |> Poison.encode!
    end
  end
end
