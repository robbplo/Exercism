defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise ArgumentError
  def nth(count) do
    Stream.unfold(2, fn x -> {x, x + 1} end)
    |> Stream.filter(&prime?/1)
    |> Stream.take(count)
    |> Enum.to_list()
    |> List.last()
  end

  defp prime?(2), do: true
  defp prime?(number) do
    2..(ceil(number / 2))
    |> Stream.filter(fn x -> rem(number, x) == 0 end)
    |> Enum.to_list()
    |> Enum.empty?()
  end
end
