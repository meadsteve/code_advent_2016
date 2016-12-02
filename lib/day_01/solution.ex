defmodule CodeAdvent2016.Day01.Location do
  defstruct north: 0,
            east: 0,
            direction: :north
end

defmodule CodeAdvent2016.Day01 do
  alias CodeAdvent2016.Day01.Location

  def rotate(%Location{direction: :north} = location, "R"), do: %{location | direction: :east}
  def rotate(%Location{direction: :east} = location, "R"),  do: %{location | direction: :south}
  def rotate(%Location{direction: :south} = location, "R"), do: %{location | direction: :west}
  def rotate(%Location{direction: :west} = location, "R"),  do: %{location | direction: :north}

  def rotate(%Location{direction: :north} = location, "L"), do: %{location | direction: :west}
  def rotate(%Location{direction: :west} = location, "L"),  do: %{location | direction: :south}
  def rotate(%Location{direction: :south} = location, "L"), do: %{location | direction: :east}
  def rotate(%Location{direction: :east} = location, "L"),  do: %{location | direction: :north}

end