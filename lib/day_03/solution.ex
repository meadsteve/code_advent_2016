defmodule CodeAdvent2016.Day03.Triangles do

  def valid?([x, y, z]) do
    (x + y > z) && (x + z > y) && (z + y > x)
  end

end

defmodule CodeAdvent2016.Day03.VerticalReader do

  def to_triangles(input) do
    input
    |> Stream.chunk(3)
    |> Stream.flat_map(&triangles_from_columns/1)
  end

  defp triangles_from_columns([[x1, y1, z1], [x2, y2, z2], [x3, y3, z3]]) do
  [
    [x1, x2, x3],
    [y1, y2, y3],
    [z1, z2, z3]
  ]
  end
end

defmodule CodeAdvent2016.Day03.PartOne do
  alias CodeAdvent2016.Day03.Triangles
  @file_path "lib/day_03/input.txt"

  def run() do
    read_in_data
    |> Stream.filter(&Triangles.valid?/1)
    |> Enum.count
   end

   def read_in_data() do
     @file_path
     |> File.stream!
     |> Stream.map(&String.trim/1)
     |> Stream.map(&String.split(&1, ~r{\s+}, trim: true))
     |> Stream.map(&to_ints/1)
   end

   defp to_ints(strings) do
     Enum.map(strings, &String.to_integer/1)
   end
end

defmodule CodeAdvent2016.Day03.PartTwo do
  alias CodeAdvent2016.Day03.Triangles
  alias CodeAdvent2016.Day03.VerticalReader
  alias CodeAdvent2016.Day03.PartOne


  def run() do
    PartOne.read_in_data
    |> VerticalReader.to_triangles
    |> Stream.filter(&Triangles.valid?/1)
    |> Enum.count
   end

end