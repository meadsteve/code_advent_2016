defmodule CodeAdvent2016.Day01.Location do
  defstruct north: 0,
            east: 0,
            direction: :north

  def rotate(%__MODULE__{direction: :north} = location, "R"), do: %{location | direction: :east}
  def rotate(%__MODULE__{direction: :east}  = location, "R"), do: %{location | direction: :south}
  def rotate(%__MODULE__{direction: :south} = location, "R"), do: %{location | direction: :west}
  def rotate(%__MODULE__{direction: :west}  = location, "R"), do: %{location | direction: :north}

  def rotate(%__MODULE__{direction: :north} = location, "L"), do: %{location | direction: :west}
  def rotate(%__MODULE__{direction: :west}  = location, "L"), do: %{location | direction: :south}
  def rotate(%__MODULE__{direction: :south} = location, "L"), do: %{location | direction: :east}
  def rotate(%__MODULE__{direction: :east}  = location, "L"), do: %{location | direction: :north}

  def move(%__MODULE__{direction: :north, north: old_value}  = location, change), do: %{location | north: old_value + change}
  def move(%__MODULE__{direction: :south, north: old_value}  = location, change), do: %{location | north: old_value - change}

  def move(%__MODULE__{direction: :east, east: old_value}  = location, change), do: %{location | east: old_value + change}
  def move(%__MODULE__{direction: :west, east: old_value}  = location, change), do: %{location | east: old_value - change}

  def distance(%__MODULE__{north: north, east: east}) do
    abs(north) + abs(east)
  end

end

defmodule CodeAdvent2016.Day01 do
  alias CodeAdvent2016.Day01.Location
  @file_path "lib/day_01/input.txt"

  def run() do
    @file_path
      |> File.read!
      |> String.split(",")
      |> Stream.map(&String.trim/1)
      |> Stream.map(&split_direction_distance/1)
      |> Enum.reduce(%Location{}, &apply_change/2)
      |> Location.distance
      |> IO.inspect
  end

  defp split_direction_distance("R" <> distance), do: {"R", String.to_integer(distance)}
  defp split_direction_distance("L" <> distance), do: {"L", String.to_integer(distance)}

  defp apply_change({rotate, move}, %Location{} = location) do
    location
    |> Location.rotate(rotate)
    |> Location.move(move)
  end


end