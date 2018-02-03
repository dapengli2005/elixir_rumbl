defmodule Rumbl.Repo do
  def all(Rumbl.User) do
    [
      %Rumbl.User{ id: "1", name: "Jose", username: "josevalim", password: "elixir" },
      %Rumbl.User{ id: "2", name: "Bruce", username: "redrapids", password: "7lang" },
      %Rumbl.User{ id: "3", name: "Chris", username: "chrismccord", password: "phx" }
    ]
  end

  def all(_module) do
    []
  end

  def get(module, id) do
    all(module)
    |> Enum.find fn map -> map.id == id end
  end

  def get_by(module, params) do
    match_all = fn map ->
      params
      |> Enum.all? fn {k, v} -> Map.get(map, k) == v end
    end

    all(module)
    |> Enum.filter match_all
  end
end
