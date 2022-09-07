defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    case number do
      number when rem(number, 3 * 5 * 7) == 0 -> "PlingPlangPlong"
      number when rem(number, 5 * 7) == 0 -> "PlangPlong"
      number when rem(number, 3 * 7) == 0 -> "PlingPlong"
      number when rem(number, 3 * 5) == 0 -> "PlingPlang"
      number when rem(number, 7) == 0 -> "Plong"
      number when rem(number, 5) == 0 -> "Plang"
      number when rem(number, 3) == 0 -> "Pling"
      _ -> number |> to_string()
    end
  end
end
