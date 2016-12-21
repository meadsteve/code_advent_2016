defmodule CodeAdvent2016.Day07.AbbaDetector do

  def has_abba?(string) when is_list(string) do
    string
    |> Enum.any?(&has_abba?/1)
  end

  def has_abba?(part) do
    part
    |> String.graphemes
    |> has_reversed_pair?
  end

  def has_reversed_pair?([_single]),                        do: false
  def has_reversed_pair?([]),                               do: false
  def has_reversed_pair?([x, y, y, x | _rest]) when x != y, do: true
  def has_reversed_pair?([_drop | rest]),                   do: has_reversed_pair?(rest)

end

defmodule CodeAdvent2016.Day07.Address do
  @hypernet ~r/\[([^\]]+)\]/

  def primary_parts(string) do
    String.split(string, @hypernet)
  end

  def hypernets_only(string) do
    Regex.scan(@hypernet, string)
    |> Enum.map(fn [_whole, contents] -> contents end)
  end

end

defmodule CodeAdvent2016.Day07.PartOne do
  alias CodeAdvent2016.Day07.AbbaDetector
  alias CodeAdvent2016.Day07.Address

  @file_path "lib/day_07/input.txt"

  def lines() do
    @file_path
    |> File.stream!
    |> Stream.map(&String.trim/1)
  end

  def run() do
    lines()
    |> Stream.filter(&supports_tls?/1)
    |> Enum.count
  end

  def supports_tls?(input) do
    has_abba?(input)
    && !has_hypernet_abba?(input)
  end

  def has_abba?(input) do
    input
    |> Address.primary_parts
    |> Enum.any?(&AbbaDetector.has_abba?/1)
  end

  def has_hypernet_abba?(input) do
    input
    |> Address.hypernets_only
    |> Enum.any?(&AbbaDetector.has_abba?/1)
  end

end