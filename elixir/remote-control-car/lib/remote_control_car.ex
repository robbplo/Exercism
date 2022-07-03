defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [
    :nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0
  ]

  def new(nickname \\ "none") do
    %__MODULE__{
      nickname: nickname
    }
  end

  def display_distance(%__MODULE__{distance_driven_in_meters: distance}), do: "#{distance} meters"

  def display_battery(%__MODULE__{battery_percentage: 0}), do: "Battery empty"
  def display_battery(%__MODULE__{battery_percentage: battery}), do: "Battery at #{battery}%"

  def drive(car = %__MODULE__{battery_percentage: 0}), do: car

  def drive(car = %__MODULE__{}) do
    %{
      car
      | battery_percentage: car.battery_percentage - 1,
        distance_driven_in_meters: car.distance_driven_in_meters + 20
    }
  end
end
