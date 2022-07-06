defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates), do: Enum.filter(candidates, &anagram_of?(base, &1))

  defp anagram_of?(base, test) do
    if String.downcase(base) == String.downcase(test), do: false, else: normalize(base) == normalize(test)
  end

  defp normalize(word) do
    word
    |> String.downcase()
    |> to_charlist()
    |> Enum.sort()
  end
end
