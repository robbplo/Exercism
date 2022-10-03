defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&rotate_char(&1, shift))
    |> List.to_string()
  end

  defp rotate_char(char, shift) when char in ?a..?z and char + shift > ?z, do: char + shift - 26
  defp rotate_char(char, shift) when char in ?A..?Z and char + shift > ?Z, do: char + shift - 26
  defp rotate_char(char, shift) when char in ?a..?z or char in ?A..?Z, do: char + shift
  defp rotate_char(char, _), do: char
end
