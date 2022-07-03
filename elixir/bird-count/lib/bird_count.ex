defmodule BirdCount do
  @moduledoc """
  Keep track of how many birds have visited your garden.
  """

  @doc """
  Returns the amount of birds spotted today
  """
  def today([]), do: nil
  def today(list), do: hd(list)

  @doc """
  Increments the amount of birds spotted today
  """
  def increment_day_count([]), do: [1]
  def increment_day_count([head | tail]), do: [head + 1 | tail]

  @doc """
  Checks if the given list has any days where no birds were spotted
  """
  def has_day_without_birds?([]), do: false
  def has_day_without_birds?([head | _tail]) when head == 0, do: true
  def has_day_without_birds?([_head | tail]), do: has_day_without_birds?(tail)

  @doc """
  Returns the total amount of birds spotted on all days
  """
  def total([]), do: 0
  def total([head | tail]), do: head + total(tail)

  @doc """
  Returns the amount of days where more than five birds were spotted
  """
  def busy_days([]), do: 0
  def busy_days([head | tail]) when head >= 5, do: busy_days(tail) + 1
  def busy_days([_ | tail]), do: busy_days(tail)
end
