defmodule CodeAdvent2016.Day05.Hash do

  def hash(input), do: Base.encode16(:erlang.md5(input), case: :lower)

  def interesting?("00000" <> _rest_of_hash), do: true
  def interesting?(_hash),                    do: false

  def password_character("00000" <> rest_of_hash), do: String.slice(rest_of_hash, 0..0)
  def password_character(_),                       do: ""
end

defmodule CodeAdvent2016.Day05.PartOne do
  alias CodeAdvent2016.Day05.Hash

  def run() do
    all_integers
    |> Stream.map(fn i -> Hash.hash("abbhdwsy#{i}") end)
    |> Stream.filter(&Hash.interesting?/1)
    |> Stream.map(&Hash.password_character/1)
    |> Enum.take(8)
    |> Enum.join()
  end

  defp all_integers(), do: Stream.unfold(0, fn n -> {n, n + 1} end)

end