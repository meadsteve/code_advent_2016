defmodule CodeAdvent2016.Day09.PartOne.Decoder do

  def decode(string) do
    string
    |> String.graphemes
    |> build([])
    |> Enum.reverse
    |> Enum.join
  end

  defp build([], output), do: output
  defp build(["(" | rest], output) do
    {command, after_command} = get_next_command(rest)
    {new_entries, after_application} = apply_command(command, after_command)
    build(after_application, [new_entries |output])
  end
  defp build([l | rest], output) do
    build(rest, [l | output])
  end

  defp get_next_command(rest), do: get_next_command(rest, [])
  defp get_next_command([")" | rest], command) do
    [x, y] = command
    |> Enum.reverse
    |> Enum.join
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)

    {[x, y], rest}
  end
  defp get_next_command([command_part | rest], command) do
    get_next_command(rest, [command_part | command])
  end

  defp apply_command([x, y], input) do
    to_repeat = input |> Enum.take(x)
    output = 1..y
    |> Enum.flat_map(fn _ -> to_repeat end)
    {output, input |> Enum.drop(x)}
  end

end

defmodule CodeAdvent2016.Day09.PartTwo.Decoder do

  def decode(list) when is_list(list) do
    list
    |> build([])
    |> Enum.reverse
  end
  def decode(string) do
    string
    |> String.graphemes
    |> decode
    |> Enum.join
  end

  defp build([], output), do: output
  defp build(["(" | rest], output) do
    {command, after_command} = get_next_command(rest)
    {new_entries, after_application} = apply_command(command, after_command)
    build(after_application, [new_entries |output])
  end
  defp build([l | rest], output) do
    build(rest, [l | output])
  end

  defp get_next_command(rest), do: get_next_command(rest, [])
  defp get_next_command([")" | rest], command) do
    [x, y] = command
    |> Enum.reverse
    |> Enum.join
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)

    {[x, y], rest}
  end
  defp get_next_command([command_part | rest], command) do
    get_next_command(rest, [command_part | command])
  end

  defp apply_command([x, y], input) do
    to_repeat = input |> Enum.take(x) |> decode
    output = 1..y
    |> Enum.flat_map(fn _ -> to_repeat end)
    {output, input |> Enum.drop(x)}
  end

end
defmodule CodeAdvent2016.Day09.PartTwo.Lengther do

  def decoded_length(list) when is_list(list) do
    list
    |> build(0)
  end
  def decoded_length(string) do
    string
    |> String.graphemes
    |> decoded_length
  end

  defp build([], count), do: count
  defp build(["(" | rest], count) do
    {command, after_command} = get_next_command(rest)
    {new_total, after_application} = apply_command(command, after_command)
    build(after_application, count + new_total)
  end
  defp build([l | rest], count) do
    build(rest, count + 1)
  end

  defp get_next_command(rest), do: get_next_command(rest, [])
  defp get_next_command([")" | rest], command) do
    [x, y] = command
    |> Enum.reverse
    |> Enum.join
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)

    {[x, y], rest}
  end
  defp get_next_command([command_part | rest], command) do
    get_next_command(rest, [command_part | command])
  end

  defp apply_command([x, y], input) do
    count = input |> Enum.take(x) |> decoded_length
    {count * y, input |> Enum.drop(x)}
  end

end

defmodule CodeAdvent2016.Day09.PartOne do
  alias CodeAdvent2016.Day09.PartOne.Decoder
  @file_path "lib/day_09/input.txt"

  def lines() do
    @file_path
    |> File.read!()
  end

  def run() do
    lines()
    |> Decoder.decode
    |> String.trim
    |> String.length
  end
end

defmodule CodeAdvent2016.Day09.PartTwo do
  alias CodeAdvent2016.Day09.PartOne
  alias CodeAdvent2016.Day09.PartTwo.Lengther

  def run() do
    PartOne.lines()
    |> String.trim
    |> Lengther.decoded_length
  end
end
