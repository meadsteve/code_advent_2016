defmodule CodeAdvent2016.Day02.SolutionTest do
  use ExUnit.Case
  alias CodeAdvent2016.Day02.Grid
  alias CodeAdvent2016.Day02.Line

  test "Each key has co-ords centered on 5" do
    assert Grid.key({-1, 1}) == "1"
    assert Grid.key({0, 1})  == "2"
    assert Grid.key({1, 1})  == "3"

    assert Grid.key({-1, 0}) == "4"
    assert Grid.key({0, 0})  == "5"
    assert Grid.key({1, 0})  == "6"

    assert Grid.key({-1, -1}) == "7"
    assert Grid.key({0, -1})  == "8"
    assert Grid.key({1, -1})  == "9"
  end

  test "movement can happen in 4 directions" do
    assert Grid.move({0, 0}, "U") == {0, 1}
    assert Grid.move({0, 0}, "D") == {0, -1}
    assert Grid.move({0, 0}, "L") == {-1, 0}
    assert Grid.move({0, 0}, "R") == {1, 0}
  end

  test "movement off grid is ignored" do
    up_a_lot = {0, 0}
    |> Grid.move("U")
    |> Grid.move("U")
    |> Grid.move("U")

    assert up_a_lot == {0, 1}

    left_a_lot = {0, 0}
    |> Grid.move("L")
    |> Grid.move("L")
    |> Grid.move("L")
    |> Grid.move("L")

    assert left_a_lot == {-1, 0}
  end

  test "follow whole line to a key" do
    assert Line.process("ULL", {0, 0}) == {"1", {-1, 1}}
  end

end