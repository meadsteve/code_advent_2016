defmodule CodeAdvent2016.Day09SolutionTest do
  use ExUnit.Case
  alias CodeAdvent2016.Day09.PartOne
  alias CodeAdvent2016.Day09.PartTwo

  test "ADVENT decodes to ADVENT" do
    assert PartOne.Decoder.decode("ADVENT") == "ADVENT"
  end

  test "A(1x5)BC becomes ABBBBBC" do
    assert PartOne.Decoder.decode("A(1x5)BC") == "ABBBBBC"
  end

  test "A(2x2)BCD(2x2)EFG becomes ABCBCDEFEFG" do
    assert PartOne.Decoder.decode("A(2x2)BCD(2x2)EFG") == "ABCBCDEFEFG"
  end

  test "(6x1)(1x3)A becomes (1x3)A" do
    assert PartOne.Decoder.decode("(6x1)(1x3)A") == "(1x3)A"
  end

  test "X(8x2)(3x3)ABCY becomes X(3x3)ABC(3x3)ABCY" do
    assert PartOne.Decoder.decode("X(8x2)(3x3)ABCY") == "X(3x3)ABC(3x3)ABCY"
  end

  test "X(8x2)(3x3)ABCY becomes XABCABCABCABCABCABCY" do
    assert PartTwo.Decoder.decode("X(8x2)(3x3)ABCY") == "XABCABCABCABCABCABCY"
  end

  test "X(8x2)(3x3)ABCY can have its length calculated'" do
    assert PartTwo.Lengther.decoded_length("X(8x2)(3x3)ABCY") == String.length("XABCABCABCABCABCABCY")
  end

  test "(27x12)(20x12)(13x14)(7x10)(1x12)A is X long" do
    assert PartTwo.Lengther.decoded_length("(27x12)(20x12)(13x14)(7x10)(1x12)A") == 241920
  end

  @tag :solutions
  test "Part 1 solution" do
    assert PartOne.run == 102239
  end

  @tag :solutions
  test "Part 2 solution" do
    assert PartTwo.run == 102239
  end

end