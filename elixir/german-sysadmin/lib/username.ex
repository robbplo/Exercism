defmodule Username do
  @doc """
  Removes anything but lowercase letters, except underscores.
  German characters are subsituted for their Latin counterparts
  """
  @spec sanitize(charlist()) :: charlist()
  def sanitize(''), do: ''

  def sanitize([char | t]) do
    case char do
      char when char == ?ä -> 'ae'
      char when char == ?ö -> 'oe'
      char when char == ?ü -> 'ue'
      char when char == ?ß -> 'ss'
      char when char in ?a..?z -> [char]
      char when char == ?_ -> '_'
      _ -> ''
    end
    |> Kernel.++(sanitize(t))
  end
end
