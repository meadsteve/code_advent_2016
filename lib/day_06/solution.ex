defmodule CodeAdvent2016.Day06.PartOne.Counter do

  def update_count(input, count_map) do
    input
    |> String.graphemes
    |> Stream.with_index
    |> Enum.reduce(count_map, &add_to_map/2)
  end

  def most_common(letter_map) do
    [most_common] = letter_map
    |> Enum.sort(fn ({_, count1}, {_, count2}) -> count1 > count2 end)
    |> Stream.map(fn ({letter, _}) -> letter end)
    |> Enum.take(1)

    most_common
  end

  defp add_to_map({letter, position}, count_map) do
    Map.update(
      count_map,
      position,
      %{letter => 1},
      &increment_letter_count(&1, letter)
    )
  end

  defp increment_letter_count(counts, letter) do
    Map.update(
      counts,
      letter,
      1,
      &(&1 + 1)
    )
  end
end

defmodule CodeAdvent2016.Day06.PartOne do
  alias CodeAdvent2016.Day06.PartOne.Counter
  @file_path "lib/day_06/input.txt"

  def run() do
    @file_path
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Enum.reduce(%{}, &Counter.update_count/2)
    |> Enum.map(fn {position, letters} -> Counter.most_common(letters) end)
    |> Enum.join
  end

end