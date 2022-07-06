defmodule ArmstrongNumber do
  @moduledoc """
  Provides a way to validate whether or not a number is an Armstrong number
  """

  @spec valid?(integer) :: boolean
  def valid?(number) do
    digits = Integer.digits(number)

    digits
    |> Enum.reduce(0, & &2 + Integer.pow(&1, length(digits)))
    |> Kernel.==(number)
  end
end
