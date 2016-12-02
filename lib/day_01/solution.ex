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

end

defmodule CodeAdvent2016.Day01 do


end