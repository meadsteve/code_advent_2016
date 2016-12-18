defmodule CodeAdvent2016.Day04.Room do
  defstruct encoded_room_name: "",
            sector_id: 0,
            checksum: ""

  @string_pattern ~r/(?<letters>[a-z\-]+)\-(?<sector_id>[0-9]+)\[(?<checksum>[a-z]{5})\]/i

  def from_string(input) do
    parts = input
    |> String.trim
    |> matches

    %__MODULE__{
      encoded_room_name: parts["letters"],
      sector_id:         String.to_integer(parts["sector_id"]),
      checksum:          parts["checksum"]
    }
  end

  defp matches(string), do: Regex.named_captures(@string_pattern, string)

  def real?(%__MODULE__{encoded_room_name: encoded_room_name, checksum: expected_checksum}) do
    generate_checksum(encoded_room_name) == expected_checksum
  end

  defp generate_checksum(letters) do
    letters
    |> String.replace("-", "")
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

defmodule CodeAdvent2016.Day04.Decoder do
  alias CodeAdvent2016.Day04.Room

  def decode(encoded_room_name, sector_id) do
    raw = encoded_room_name
    |> String.to_charlist
    |> Enum.map(&rotate_letter(&1, sector_id))
    |> :erlang.iolist_to_binary
  end

 defp rotate_letter(?-, _), do: ' '
 defp rotate_letter(letter, sector_id),do: ?a + rem (letter - ?a + sector_id), (?z - ?a + 1)

end

defmodule CodeAdvent2016.Day04.DecodedRoom do
  alias CodeAdvent2016.Day04.Room
  alias CodeAdvent2016.Day04.Decoder

  defstruct encoded_room_name: "",
            decoded_room_name: "",
            sector_id: 0,
            checksum: ""

  def from_room(%Room{} = room) do
    %__MODULE__{
      encoded_room_name: room.encoded_room_name,
      decoded_room_name: Decoder.decode(room.encoded_room_name, room.sector_id),
      sector_id: room.sector_id,
      checksum: room.checksum
    }
  end
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

defmodule CodeAdvent2016.Day04.PartTwo do
  @file_path "lib/day_04/input.txt"
  alias CodeAdvent2016.Day04.Room
  alias CodeAdvent2016.Day04.DecodedRoom

  def run() do
    [result] = @file_path
    |> File.stream!
    |> Stream.map(&Room.from_string/1)
    |> Stream.filter(&Room.real?/1)
    |> Stream.map(&DecodedRoom.from_room/1)
    |> Stream.filter(fn room -> room.decoded_room_name == "northpole object storage" end)
    |> Enum.take(1)

    result
  end

end