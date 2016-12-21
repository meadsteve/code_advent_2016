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

  defp has_reversed_pair?([_single]),                        do: false
  defp has_reversed_pair?([]),                               do: false
  defp has_reversed_pair?([x, y, y, x | _rest]) when x != y, do: true
  defp has_reversed_pair?([_drop | rest]),                   do: has_reversed_pair?(rest)

end

defmodule CodeAdvent2016.Day07.Tla do

  def list_bab(input), do: list_aba(input)

  def list_aba(input) when is_list(input) do
    Enum.flat_map(input, &list_aba/1)
  end

  def list_aba(string) do
    string
    |> String.graphemes
    |> find_aba_triplets([])
    |> Enum.uniq
  end

  def find_aba_triplets([] = input, acc), do: acc
  def find_aba_triplets([x, y, x | rest], acc) when x != y, do: find_aba_triplets([y, x | rest], [ [x, y] | acc])
  def find_aba_triplets([ _ | rest], acc), do: find_aba_triplets(rest, acc)


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

defmodule CodeAdvent2016.Day07.PartTwo do
  alias CodeAdvent2016.Day07.Address
  alias CodeAdvent2016.Day07.Tla
  alias CodeAdvent2016.Day07.PartOne

  def run() do
    PartOne.lines()
    |> Stream.filter(&supports_ssl?/1)
    |> Enum.count
  end

  def supports_ssl?(address) do
    abas = address
    |> Address.primary_parts
    |> Tla.list_aba

    address
    |> Address.hypernets_only
    |> Tla.list_bab
    |> are_any_reversed_pairs_found?(abas)
  end

  def are_any_reversed_pairs_found?(set_one, set_two) do
    set_one
    |> Stream.map(fn [a, b] -> [b ,a] end)
    |> Enum.any?(&Enum.member?(set_two, &1))
  end
end