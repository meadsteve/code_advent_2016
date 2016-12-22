defmodule CodeAdvent2016.Day09.Decoder do

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
defmodule CodeAdvent2016.Day09.PartOne do
  alias CodeAdvent2016.Day09.Decoder
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
