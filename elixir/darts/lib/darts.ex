defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    distance = distance({x, y})

    cond do
      distance > 10 -> 0  
      distance > 5 -> 1
      distance > 1 -> 5
      true -> 10
    end
  end

  def distance({x, y}) do
    :math.sqrt(x ** 2 + y ** 2)
  end
end
