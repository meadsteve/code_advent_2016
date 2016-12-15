defmodule CodeAdvent2016.Day03.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day03.Triangles

  test "Valid triangles are valid" do
    assert Triangles.valid?([5, 10, 11])
  end

  test "Invalid triangles are invalid" do
    refute Triangles.valid?([5, 10, 25])
    refute Triangles.valid?([25, 10, 5])
  end

end