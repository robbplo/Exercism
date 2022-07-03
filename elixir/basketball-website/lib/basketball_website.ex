defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    navigate_map(data, String.split(path, "."))
  end

  defp navigate_map(data, []), do: data
  defp navigate_map(data, [h | t]), do: navigate_map(data[h], t)

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
