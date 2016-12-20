defmodule CodeAdvent2016.Day07.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day07.AbbaDetector
  alias CodeAdvent2016.Day07.Hypernet

  test "abba[mnop]qrst and qrst[mnop]xyyx have abba" do
    assert AbbaDetector.has_abba?("abba[mnop]qrst") === true
    assert AbbaDetector.has_abba?("qrst[mnop]xyyx") === true
  end

  test "ioxxoj[asdfgh]zxcvbn as abba " do
    assert AbbaDetector.has_abba?("ioxxoj[asdfgh]zxcvbn") === true
  end

  test "aaaa[qwer]tyui doesnt have abba" do
    assert AbbaDetector.has_abba?("aaaa[qwer]tyui") === false
  end

  test "abab[mnop]qrst doesnt have abba" do
    assert AbbaDetector.has_abba?("abab[mnop]qrst") === false
  end

  test "xyab[qwer]baer doesnt have abba (abba can't be matched accross a hypernet')" do
    assert AbbaDetector.has_abba?("xyab[qwer]baer") === false
  end


  test "abab[abba]qrst can be filtered to only the hypernet abba" do
    assert Hypernet.hypernets_only("abab[abba]qrst") == ["abba"]
  end

  test "abab[abba]qrst can be filtered to only the hypernet abba " do
    assert Hypernet.hypernets_only("abab[abba]qrst[derfd]") == ["abba", "derfd"]
  end

  test "abab[abba]qrst has a hypernet abba" do
    result = "abab[abba]qrst"
    |> Hypernet.hypernets_only
    |> Enum.any?(&AbbaDetector.has_abba?/1)

    assert result == true
  end

  test "according to part 1 abcd[bddb]xyyx does not support tls" do
    assert CodeAdvent2016.Day07.PartOne.supports_tls?("abcd[bddb]xyyx") === false
  end

  @tag :solutions
  test "Part 1 solution" do
    assert CodeAdvent2016.Day07.PartOne.run == ""
  end

end