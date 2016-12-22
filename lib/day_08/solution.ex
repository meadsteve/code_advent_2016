defmodule CodeAdvent2016.Day08.Screen do
  def new(max_x, max_y) do
    map_line(max_x, map_line(max_y, 0))
  end

  def set(grid, {x, y}, value) do
    Map.update!(grid, x, fn row ->
       Map.update!(row, y, fn _ -> value end)
    end)
  end
  def get(grid, {x, y}), do: grid[x][y]

  def set_grid(grid, to_x, to_y) do
    max_x = row_length(grid)
    max_y = col_length(grid)
    for x <- 0..to_x, y <- 0..to_y, x <= max_x, y <= max_y do
      {x, y}
    end
    |> Enum.reduce(grid, fn(coord, updated_grid) ->
      set(updated_grid, coord, 1)
    end)
  end

  def row_length(grid), do: Enum.count(grid[0]) - 1
  def col_length(grid), do: Enum.count(grid) - 1

  defp map_line(length, value) do
    for x <- 0..length - 1 do
      {x, value}
    end
    |> Enum.into(%{})
  end
end

defmodule CodeAdvent2016.Day08.Shifter do
  alias CodeAdvent2016.Day08.Screen

  def right(screen, row_offset, amount) do
    row_max = Screen.row_length(screen)
    Enum.reduce(0..row_max, screen, fn x, updated_screen ->
      x_to_copy = ongrid(x - amount, row_max)
      new_value = Screen.get(screen, {row_offset, x_to_copy})
      Screen.set(updated_screen, {row_offset, x}, new_value)
    end)
  end

  def down(screen, col_offset, amount) do
    col_max = Screen.col_length(screen)
    Enum.reduce(0..col_max, screen, fn y, updated_screen ->
      y_to_copy = ongrid(y - amount, col_max)
      new_value = Screen.get(screen, {y_to_copy, col_offset})
      Screen.set(updated_screen, {y, col_offset}, new_value)
    end)
  end

  defp ongrid(value, max) when value >= 0 and value <= max, do: value
  defp ongrid(value, max) when value < 0,   do: ongrid(1 + max + value, max)
  defp ongrid(value, max) when value > max, do: ongrid(value - max, max)
end

defmodule CodeAdvent2016.Day08.PartOne do
  alias CodeAdvent2016.Day08.Screen
  alias CodeAdvent2016.Day08.Shifter
  @file_path "lib/day_08/input.txt"

  def lines() do
    @file_path
    |> File.stream!
    |> Stream.map(&String.trim/1)
  end

  def run() do
    starting_display = Screen.new(6, 50)
    lines()
    |> Enum.reduce(starting_display, &apply_line/2)
    |> IO.inspect
    |> count_lights
  end

  defp count_lights(grid) do
    Enum.map(grid, &count_lights_in_row/1)
    |> Enum.sum
  end

  defp count_lights_in_row({_, row}) do
    Enum.map(row, fn ({_, x}) -> x end)
    |> Enum.sum
  end


  defp apply_line("rect " <> data, screen) do
    [a, b] = split(data, "x")
    Screen.set_grid(screen, b, a)
  end
  defp apply_line("rotate row y=" <> data, screen) do
     [a, b] = split(data, " by ")
     Shifter.right(screen, a , b)
  end
  defp apply_line("rotate column x=" <> data, screen) do
     [a, b] = split(data, " by ")
     Shifter.down(screen, a, b)
  end

  defp split(data, by) do
    [_a, _b] = data
    |> String.trim
    |> String.split(by)
    |> Enum.map(&String.to_integer/1)
  end

end
