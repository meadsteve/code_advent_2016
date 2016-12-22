defmodule CodeAdvent2016.Day08.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day08.Screen
  alias CodeAdvent2016.Day08.Shifter

  test "Screens can be built" do
    assert Screen.new(2, 2) == %{
      0 => %{ 0 => 0, 1 => 0},
      1 => %{ 0 => 0, 1 => 0},
    }

    assert Screen.new(2, 3) == %{
      0 => %{ 0 => 0, 1 => 0, 2 => 0},
      1 => %{ 0 => 0, 1 => 0, 2 => 0}
    }
  end

  test "Coords can be used to light up an element" do
    start = Screen.new(2, 2)
    assert Screen.set(start, {1, 1}, 1) == %{
      0 => %{ 0 => 0, 1 => 0},
      1 => %{ 0 => 0, 1 => 1},
    }
  end

  test "A grid can be lit up" do
    lit_screen = Screen.new(2, 2)
    |> Screen.set_grid(1, 1)

    assert lit_screen == %{
      0 => %{ 0 => 1, 1 => 1},
      1 => %{ 0 => 1, 1 => 1},
    }
  end

  test "Grids larger than our grid do no harm" do
    lit_screen = Screen.new(2, 2)
    |> Screen.set_grid(3, 3)

    assert lit_screen == %{
      0 => %{ 0 => 1, 1 => 1},
      1 => %{ 0 => 1, 1 => 1},
    }
  end


  test "rows can be shifted one to the right" do
    start = %{
      0 => %{ 0 => 0, 1 => 0, 2 => 0},
      1 => %{ 0 => 0, 1 => 1, 2 => 0},
    }
    assert Shifter.right(start, 1, 1) == %{
      0 => %{ 0 => 0, 1 => 0, 2 => 0},
      1 => %{ 0 => 0, 1 => 0, 2 => 1},
    }
  end

  test "rows can be shifted two to the right" do
    start = %{
      0 => %{ 0 => 0, 1 => 0, 2 => 0},
      1 => %{ 0 => 0, 1 => 1, 2 => 0},
    }
    assert Shifter.right(start, 1, 2) == %{
      0 => %{ 0 => 0, 1 => 0, 2 => 0},
      1 => %{ 0 => 1, 1 => 0, 2 => 0},
    }
  end

  test "cols can be shifted down" do
    start = %{
      0 => %{ 0 => 0, 1 => 1, 2 => 0},
      1 => %{ 0 => 0, 1 => 0, 2 => 0},
    }
    assert Shifter.down(start, 1, 1) == %{
      0 => %{ 0 => 0, 1 => 0, 2 => 0},
      1 => %{ 0 => 0, 1 => 1, 2 => 0},
    }
  end

  @tag :solutions
  test "Part 1 solution" do
    assert CodeAdvent2016.Day08.PartOne.run == 0
  end

end