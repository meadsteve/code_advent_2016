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

defmodule CodeAdvent2016.Day01.Input do
  @file_path "lib/day_01/input.txt"

  def load() do
    @file_path
      |> File.read!
      |> String.split(",")
      |> Stream.map(&String.trim/1)
      |> Stream.map(&split_direction_distance/1)
  end

  defp split_direction_distance("R" <> distance), do: {"R", String.to_integer(distance)}
  defp split_direction_distance("L" <> distance), do: {"L", String.to_integer(distance)}

end

defmodule CodeAdvent2016.Day01.PartOne do
  alias CodeAdvent2016.Day01.Location
  alias CodeAdvent2016.Day01.Input

  def run() do
    Input.load()
      |> Enum.reduce(%Location{}, &apply_change/2)
      |> Location.distance
      |> IO.inspect
  end

  defp apply_change({rotate, move}, %Location{} = location) do
    location
    |> Location.rotate(rotate)
    |> Location.move(move)
    |> IO.inspect
  end

end

defmodule CodeAdvent2016.Day01.PartTwo do
  alias CodeAdvent2016.Day01.Location
  alias CodeAdvent2016.Day01.Input

  def run() do
    Input.load()
      |> Enum.reduce_while({%Location{}, MapSet.new}, &apply_change/2)
      |> drop_history
      |> Location.distance
      |> IO.inspect
  end

  defp apply_change({rotate, move}, {%Location{} = location, history}) do
    new_location = Location.rotate(location, rotate)
    move_forward(move, {new_location, history})
  end

  defp move_forward(0, data), do: {:cont, data}
  defp move_forward(move, {%Location{} = location, history})
  when move > 0
  do
    updated_history = MapSet.put(history, {location.north, location.east})
    new_location = Location.move(location, 1)
    if MapSet.member?(history, {new_location.north, new_location.east}) do
      {:halt, {new_location, updated_history}}
    else
      move_forward(move - 1, {new_location, updated_history})
    end
  end

  defp drop_history({location, _history}), do: location

end