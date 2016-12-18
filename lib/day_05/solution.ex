defmodule CodeAdvent2016.Day05.Hash do

  def hash(input), do: Base.encode16(:erlang.md5(input), case: :lower)

  def interesting?("00000" <> _rest_of_hash), do: true
  def interesting?(_hash),                    do: false

  def password_character("00000" <> rest_of_hash), do: String.slice(rest_of_hash, 0..0)

  def password_character_and_position("00000" <> rest_of_hash) do
    [pos, char] = rest_of_hash
    |> String.slice(0..1)
    |> String.graphemes

    {pos, char}
  end

end

defmodule CodeAdvent2016.Day05.PartOne do
  alias CodeAdvent2016.Day05.Hash

  @input "abbhdwsy"

  def interesting_hashes() do
    all_integers
    |> Stream.map(fn i -> Hash.hash("#{@input}#{i}") end)
    |> Stream.filter(&Hash.interesting?/1)
  end

  def run() do
    interesting_hashes
    |> Stream.map(&Hash.password_character/1)
    |> Enum.take(8)
    |> Enum.join
  end

  defp all_integers(), do: Stream.unfold(0, fn n -> {n, n + 1} end)

end

defmodule CodeAdvent2016.Day05.PartTwo do
  alias CodeAdvent2016.Day05.PartOne
  alias CodeAdvent2016.Day05.Hash

  def run() do
    PartOne.interesting_hashes
    |> Stream.map(&Hash.password_character_and_position/1)
    |> Stream.filter(&valid_position?/1)
    |> Stream.uniq(fn {p, _} -> p end)
    |> Enum.take(8)
    |> Enum.sort(fn {p1, _}, {p2, _} -> p1 < p2 end)
    |> Enum.map(fn {_, l} -> l end)
    |> Enum.join
  end

  #TODO: this properly
  def valid_position?({"0", _}), do: true
  def valid_position?({"1", _}), do: true
  def valid_position?({"2", _}), do: true
  def valid_position?({"3", _}), do: true
  def valid_position?({"4", _}), do: true
  def valid_position?({"5", _}), do: true
  def valid_position?({"6", _}), do: true
  def valid_position?({"7", _}), do: true
  def valid_position?(_),        do: false

end