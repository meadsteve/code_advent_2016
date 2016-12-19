defmodule CodeAdvent2016.Day06.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day06.Counter
  alias CodeAdvent2016.Day06.Finder

  test "sets up letter count at positions" do
    assert Counter.update_count("abcd", %{}) == %{
      0 => %{"a" => 1},
      1 => %{"b" => 1},
      2 => %{"c" => 1},
      3 => %{"d" => 1}
    }
  end

  test "updates existing counts" do
    start = %{
      0 => %{"a" => 1},
      1 => %{"b" => 1},
      2 => %{"c" => 1},
      3 => %{"d" => 1}
    }
    assert Counter.update_count("aacd", start) == %{
      0 => %{"a" => 2},
      1 => %{"b" => 1, "a" => 1},
      2 => %{"c" => 2},
      3 => %{"d" => 2}
    }
  end

  test "Finds the most common" do
    assert Finder.most_common(%{"b" => 2, "a" => 1}) == "b"
  end

  test "Finds the least common" do
    assert Finder.least_common(%{"b" => 2, "a" => 1}) == "a"
  end

  @tag :solutions
  test "Part 1 solution" do
    assert CodeAdvent2016.Day06.PartOne.run == "ursvoerv"
  end

  @tag :solutions
  test "Part 2 solution" do
    assert CodeAdvent2016.Day06.PartTwo.run == "ursvoerv"
  end

end