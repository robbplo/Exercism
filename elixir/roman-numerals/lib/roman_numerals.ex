defmodule RomanNumerals do
  @numerals %{
    1000 => "M",
    500 => "D",
    100 => "C",
    50 => "L",
    10 => "X",
    5 => "V",
    1 => "I"
  }

  @numeral_keys Map.keys(@numerals)

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number), do: do_numeral(number)

  defp do_numeral(0), do: ""

  defp do_numeral(number) do
    [hd | tail] = digits = Integer.digits(number)
    significance = 10 ** (length(digits) - 1)
    subtractor = get_subtractor(number)

    cond do
      (hd * significance) in @numeral_keys ->
        @numerals[hd * significance] <> do_numeral(Integer.undigits(tail))

      (hd * significance + significance) in @numeral_keys ->
        @numerals[subtractor] <>
          @numerals[hd * significance + significance] <>
          do_numeral(Integer.undigits(tail))

      true ->
        over =
          [
            hd * significance - subtractor,
            hd * significance - subtractor * 2,
            hd * significance - subtractor * 3
          ]
          |> Enum.filter(&(&1 in @numeral_keys))
          |> Enum.at(0)

        if over != nil do
          @numerals[over] <>
            do_numeral(number - over)
        else
          String.duplicate(@numerals[significance], hd) <>
            do_numeral(Integer.undigits(tail))
        end
    end
  end

  defp get_subtractor(number) when number <= 10, do: 1
  defp get_subtractor(number) when number < 100 and number > 10, do: 10
  defp get_subtractor(_), do: 100
end
