defmodule CodeAdvent2016.Day07.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day07.AbbaDetector
  alias CodeAdvent2016.Day07.Address

  test "abba[mnop]qrst and qrst[mnop]xyyx have abba" do
    assert "abba[mnop]qrst" |> Address.primary_parts |>  AbbaDetector.has_abba? === true
    assert AbbaDetector.has_abba?("qrst[mnop]xyyx") === true
  end

  test "ioxxoj[asdfgh]zxcvbn as abba " do
    assert "ioxxoj[asdfgh]zxcvbn" |> Address.primary_parts |>  AbbaDetector.has_abba? === true
  end

  test "aaaa[qwer]tyui doesnt have abba" do
    assert "aaaa[qwer]tyui" |> Address.primary_parts |>  AbbaDetector.has_abba? === false
  end

  test "abab[mnop]qrst doesnt have abba" do
    assert "abab[mnop]qrst" |> Address.primary_parts |>  AbbaDetector.has_abba? === false
  end

  test "xyab[qwer]baer doesnt have abba (abba can't be matched accross a hypernet')" do
    assert "xyab[qwer]baer" |> Address.primary_parts |>  AbbaDetector.has_abba? === false
  end


  test "abab[abba]qrst can be filtered to only the hypernet abba" do
    assert Address.hypernets_only("abab[abba]qrst") == ["abba"]
  end

  test "abab[abba]qrst can be filtered to only the hypernet abba " do
    assert Address.hypernets_only("abab[abba]qrst[derfd]") == ["abba", "derfd"]
  end

  test "abab[abba]qrst has a hypernet abba" do
    result = "abab[abba]qrst"
    |> Address.hypernets_only
    |> AbbaDetector.has_abba?

    assert result == true
  end

  test "according to part 1 abcd[bddb]xyyx does not support tls" do
    assert CodeAdvent2016.Day07.PartOne.supports_tls?("abcd[bddb]xyyx") === false
  end

  @tag :solutions
  test "Part 1 solution" do
    assert CodeAdvent2016.Day07.PartOne.run == 118
  end

end