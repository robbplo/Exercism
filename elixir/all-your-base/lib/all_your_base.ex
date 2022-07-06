defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(_, _, output_base) when output_base < 2, do: {:error, "output base must be >= 2"}
  def convert(_, input_base, _) when input_base < 2, do: {:error, "input base must be >= 2"}
  def convert([], _, _), do: {:ok, [0]}

  def convert(digits, input_base, output_base) do
    digits
    |> validate_digits(input_base)
    |> to_decimal(input_base)
    |> to_base_n(output_base)
    |> format_result()
  end

  defp format_result({:error, message}), do: {:error, message}
  defp format_result(value), do: {:ok, value}

  defp validate_digits(digits, input_base) do
      digits
      |> Enum.all?(& &1 >= 0 and &1 < input_base)
      |> then(& if !!&1, do: digits, else: {:error, "all digits must be >= 0 and < input base"})
  end

  defp to_decimal({:error, message}, _), do: {:error, message}
  defp to_decimal(digits, base) do
    digits
    |> Enum.zip((length(digits) - 1)..0)
    |> Enum.map(fn {digit, position} -> digit * base ** position end)
    |> Enum.sum()
    |> Integer.digits()
  end

  defp to_base_n(digits, base, acc \\ [])
  defp to_base_n({:error, message}, _, _), do: {:error, message}
  defp to_base_n([0], _, _), do: [0]
  defp to_base_n(0, _, acc), do: acc
  defp to_base_n(digits, base, _) when is_list(digits), do: digits |> Integer.undigits() |> to_base_n(base)
  defp to_base_n(digits, base, acc) when is_integer(digits), do: to_base_n(div(digits, base), base, [rem(digits, base) | acc])
end
