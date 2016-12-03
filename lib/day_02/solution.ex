defmodule CodeAdvent2016.Day02.Grid do
  def key({-1, 1}), do: "1"
  def key({0, 1}),  do: "2"
  def key({1, 1}),  do: "3"
  
  def key({-1, 0}), do: "4"
  def key({0, 0}),  do: "5"
  def key({1, 0}),  do: "6"
  
  def key({-1, -1}), do: "7"
  def key({0, -1}),  do: "8"
  def key({1, -1}),  do: "9"
  
  def move({x, y}, "U"), do: {x, on_grid(y + 1)}
  def move({x, y}, "D"), do: {x, on_grid(y - 1)}
  def move({x, y}, "L"), do: {on_grid(x - 1), y}
  def move({x, y}, "R"), do: {on_grid(x + 1), y}

  defp on_grid(-2), do: -1
  defp on_grid(2),  do: 1
  defp on_grid(n),  do: n
end

defmodule CodeAdvent2016.Day02.Line do
  alias CodeAdvent2016.Day02.Grid

  def process(line, {x, y}) do
    end_position = line
    |> String.graphemes
    |> Enum.reduce({x, y}, &move/2)

    {Grid.key(end_position), end_position}
  end

  defp move(direction, {x, y}), do: Grid.move({x, y}, direction)
end

defmodule CodeAdvent2016.Day02.PartOne do
  alias CodeAdvent2016.Day02.Line
  @file_path "lib/day_02/input.txt"

  def run() do
    {_, key_presses} = @file_path
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Enum.reduce({{0, 0}, []}, &process_line/2)

    key_presses
    |> Enum.reverse
    |> Enum.join
    |> IO.inspect
  end

  defp process_line(line, {{x, y}, key_presses}) do
    {key, final_position} = Line.process(line, {x, y})
    {final_position, [key | key_presses]}
  end
end