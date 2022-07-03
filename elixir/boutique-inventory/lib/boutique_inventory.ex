defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &is_nil(&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      update_in(item.name, &String.replace(&1, old_word, new_word))
    end)
  end

  def increase_quantity(item, count) do
    new_quantity = Map.new(item.quantity_by_size, fn {k, v} -> {k, v + count} end)

    put_in(item.quantity_by_size, new_quantity)
  end

  def total_quantity(item) when item.quantity_by_size == %{}, do: 0

  def total_quantity(item) do
    item.quantity_by_size
    |> Map.to_list()
    |> Keyword.values()
    |> Enum.reduce(&(&1 + &2))
  end
end
