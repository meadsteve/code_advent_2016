defmodule CodeAdvent2016.Day07.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day07.AbbaDetector
  alias CodeAdvent2016.Day07.Address
  alias CodeAdvent2016.Day07.Tla

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

  test "aba[bab]xyz has an ABA of ab in the primary parts" do
    result = "aba[bab]xyz"
    |> Address.primary_parts
    |> Tla.list_aba

    assert result == [ ["a", "b"] ]
  end

  test "zazbz[bzb]cdb has two ABAs za and zb in the primary parts" do
    result = "zazbz[bzb]cdb"
    |> Address.primary_parts
    |> Tla.list_aba

    assert result == [ ["z", "b"], ["z", "a"] ]
  end

  test "aaa[kek]eke has a BAB of ek in the hypernet" do
    result = "aaa[kek]eke"
    |> Address.hypernets_only
    |> Tla.list_bab

    assert result == [ ["k", "e"] ]
  end

  test "according to part 1 abcd[bddb]xyyx does not support tls" do
    assert CodeAdvent2016.Day07.PartOne.supports_tls?("abcd[bddb]xyyx") === false
  end

  test "according to part 2 aaa[kek]eke supports ssl" do
    assert CodeAdvent2016.Day07.PartTwo.supports_ssl?("aaa[kek]eke") === true
  end

  @tag :solutions
  test "Part 1 solution" do
    assert CodeAdvent2016.Day07.PartOne.run == 118
  end

  @tag :solutions
  test "Part 2 solution" do
    assert CodeAdvent2016.Day07.PartTwo.run == 260
  end

end