defmodule CodeAdvent2016.Day09SolutionTest do
  use ExUnit.Case
  alias CodeAdvent2016.Day09.Decoder

  test "ADVENT decodes to ADVENT" do
    assert Decoder.decode("ADVENT") == "ADVENT"
  end

  test "A(1x5)BC becomes ABBBBBC" do
    assert Decoder.decode("A(1x5)BC") == "ABBBBBC"
  end

  test "A(2x2)BCD(2x2)EFG becomes ABCBCDEFEFG" do
    assert Decoder.decode("A(2x2)BCD(2x2)EFG") == "ABCBCDEFEFG"
  end

  test "(6x1)(1x3)A becomes (1x3)A" do
    assert Decoder.decode("(6x1)(1x3)A") == "(1x3)A"
  end

  test "X(8x2)(3x3)ABCY becomes X(3x3)ABC(3x3)ABCY" do
    assert Decoder.decode("X(8x2)(3x3)ABCY") == "X(3x3)ABC(3x3)ABCY"
  end

  @tag :solutions
  test "Part 1 solution" do
    assert CodeAdvent2016.Day09.PartOne.run == 102239
  end

end