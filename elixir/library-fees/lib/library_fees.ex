defmodule LibraryFees do
  @spec datetime_from_string(string :: String.t()) :: NaiveDateTime.t()
  def datetime_from_string(string) do
    {:ok, t} = NaiveDateTime.from_iso8601(string)
    t
  end

  @spec before_noon?(datetime :: NaiveDateTime.t()) :: boolean()
  def before_noon?(datetime) do
    NaiveDateTime.to_time(datetime).hour < 12
  end

  @spec return_date(checkout_datetime :: NaiveDateTime.t()) :: Date
  def return_date(checkout_datetime) do
    days = if before_noon?(checkout_datetime), do: 28, else: 29

    Date.add(checkout_datetime, days)
  end

  @spec days_late(planned_return_date :: Date.t(), actual_return_datetime :: NaiveDateTime.t()) ::
          integer()
  def days_late(planned_return_date, actual_return_datetime) do
    diff = Date.diff(actual_return_datetime, planned_return_date)
    if diff > 0, do: diff, else: 0
  end

  @spec monday?(datetime :: NaiveDateTime.t()) :: boolean()
  def monday?(datetime) do
    Date.day_of_week(datetime) == 1
  end

  @spec calculate_late_fee(
          checkout :: NaiveDateTime.t(),
          return :: NaiveDateTime.t(),
          rate :: NaiveDateTime.t()
        ) :: non_neg_integer()
  def calculate_late_fee(checkout, return, rate) do
    checkout_datetime = datetime_from_string(checkout)
    return_datetime = datetime_from_string(return)

    checkout_datetime
    |> return_date()
    |> days_late(return_datetime)
    |> Kernel.*(rate * (if monday?(return_datetime), do: 0.5, else: 1))
    |> trunc()
  end
end
