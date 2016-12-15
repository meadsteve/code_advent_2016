defmodule CodeAdvent2016.Day03.Triangles do

  def valid?([x, y, z]) do
    (x + y > z) && (x + z > y) && (z + y > x)
  end

end

defmodule CodeAdvent2016.Day03.PartOne do
  alias CodeAdvent2016.Day03.Triangles
  @file_path "lib/day_03/input.txt"

  def run() do
    @file_path
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split(&1, ~r{\s+}, trim: true))
    |> Stream.map(&to_ints/1)
    |> Stream.filter(&Triangles.valid?/1)
    |> Enum.count
   end

   defp to_ints(strings) do
     Enum.map(strings, &String.to_integer/1)
   end
end