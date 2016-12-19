defmodule CodeAdvent2016.Day06.Counter do

  def update_count(input, count_map) do
    input
    |> String.graphemes
    |> Stream.with_index
    |> Enum.reduce(count_map, &add_to_map/2)
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

defmodule CodeAdvent2016.Day06.Finder do
    def most_common(letter_map),  do: top(letter_map, &most_common_sorter/2)
    def least_common(letter_map), do: top(letter_map, &least_common_sorter/2)

    defp top(letter_map, sorter) do
      [letter] = letter_map
      |> Enum.sort(sorter)
      |> Stream.map(fn ({letter, _}) -> letter end)
      |> Enum.take(1)

      letter
    end

    defp most_common_sorter({_, count1}, {_, count2}),  do: count1 > count2
    defp least_common_sorter({_, count1}, {_, count2}), do: count1 < count2
end

defmodule CodeAdvent2016.Day06.PartOne do
  alias CodeAdvent2016.Day06.Counter
  alias CodeAdvent2016.Day06.Finder
  @file_path "lib/day_06/input.txt"

  def counts() do
    @file_path
    |> File.stream!
    |> Stream.map(&String.trim/1)
    |> Enum.reduce(%{}, &Counter.update_count/2)
  end

  def run() do
    counts()
    |> Enum.map(fn {position, letters} -> Finder.most_common(letters) end)
    |> Enum.join
  end

end

defmodule CodeAdvent2016.Day06.PartTwo do

  alias CodeAdvent2016.Day06.PartOne

  alias CodeAdvent2016.Day06.Counter
  alias CodeAdvent2016.Day06.Finder

  def run() do
    PartOne.counts()
    |> Enum.map(fn {position, letters} -> Finder.least_common(letters) end)
    |> Enum.join
  end

end