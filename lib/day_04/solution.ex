defmodule CodeAdvent2016.Day04.Room do
  defstruct letters: "",
            sector_id: 0,
            checksum: ""

  @string_pattern ~r/(?<letters>[a-z\-]+)(?<sector_id>[0-9]+)\[(?<checksum>[a-z]{5})\]/i

  def from_string(input) do
    parts = input
    |> String.trim
    |> matches

    %__MODULE__{
      letters:   String.replace(parts["letters"], "-", ""),
      sector_id: String.to_integer(parts["sector_id"]),
      checksum:  parts["checksum"]
    }
  end

  defp matches(string), do: Regex.named_captures(@string_pattern, string)

  def real?(%__MODULE__{letters: letters, checksum: expected_checksum}) do
    generate_checksum(letters) == expected_checksum
  end

  defp generate_checksum(letters) do
    letters
    |> String.graphemes
    |> Enum.group_by(&(&1))
    |> Enum.map(fn {letter, letters} -> {letter, Enum.count(letters)} end)
    |> Enum.sort(&comparer/2)
    |> Stream.map(fn {letter, _} -> letter end)
    |> Enum.take(5)
    |> Enum.join
  end

  defp comparer({letter_1, same_count}, {letter_2, same_count}), do: letter_1 < letter_2
  defp comparer({_, count_1}, {_, count_2}), do: count_1 > count_2

end

defmodule CodeAdvent2016.Day04.PartOne do
  @file_path "lib/day_04/input.txt"
  alias CodeAdvent2016.Day04.Room

  def run() do
    @file_path
    |> File.stream!
    |> Stream.map(&Room.from_string/1)
    |> Stream.filter(&Room.real?/1)
    |> Stream.map(fn room -> room.sector_id end)
    |> Enum.sum
  end


end