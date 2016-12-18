defmodule CodeAdvent2016.Day05.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day05.Hash

  test "abc3231929 is an intetesting hash (it starts with 5 zeros)" do
    interesting? = "abc3231929"
    |> Hash.hash
    |> Hash.interesting?

    assert interesting?
  end

  test "abc3231929 represents the password character 1" do
    character = "abc3231929"
    |> Hash.hash
    |> Hash.password_character

    assert character == "1"
  end


  @tag :solutions
  @tag timeout: 30_000
  test "Part 1 solution" do
    assert CodeAdvent2016.Day05.PartOne.run == "801b56a7"
  end

end