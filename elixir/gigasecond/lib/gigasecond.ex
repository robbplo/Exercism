defmodule Gigasecond do
  @gigasecond 1_000_000_000

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) ::
          {{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}
  def from(input_datetime_tuple) do
    input_datetime_tuple
    |> NaiveDateTime.from_erl!()
    |> NaiveDateTime.add(@gigasecond, :second)
    |> NaiveDateTime.to_erl()
  end
end
