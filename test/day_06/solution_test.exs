defmodule CodeAdvent2016.Day06.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day06.PartOne.Counter

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
    assert Counter.most_common(%{"b" => 2, "a" => 1}) == "b"
  end

  @tag :solutions
  test "Part 1 solution" do
    assert CodeAdvent2016.Day06.PartOne.run == ""
  end

end