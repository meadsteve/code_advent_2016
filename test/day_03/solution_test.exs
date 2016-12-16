defmodule CodeAdvent2016.Day03.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day03.Triangles
  alias CodeAdvent2016.Day03.VerticalReader

  test "Valid triangles are valid" do
    assert Triangles.valid?([5, 10, 11])
  end

  test "Invalid triangles are invalid" do
    refute Triangles.valid?([5, 10, 25])
    refute Triangles.valid?([25, 10, 5])
  end

  test "Complete solution part one" do
    assert CodeAdvent2016.Day03.PartOne.run == 862
  end

  test "VerticalReader works" do
    input = [
      [101, 301, 501],
      [102, 302, 502],
      [103, 303, 503]
    ]
    expected_triangles = [
      [101, 102, 103],
      [301, 302, 303],
      [501, 502, 503]
    ]

    assert (input |> VerticalReader.to_triangles |> Enum.take(3)) == expected_triangles
  end

  test "Complete solution part two" do
    assert CodeAdvent2016.Day03.PartTwo.run == 1577
  end

end