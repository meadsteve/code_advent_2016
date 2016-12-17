defmodule CodeAdvent2016.Day04.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day04.Room

  test "Room string is parsed in to a struct" do
    assert Room.from_string("aaaaa-bbb-z-y-x-123[abxyz]") == %Room{
      letters: "aaaaabbbzyx",
      raw_letters: "aaaaa-bbb-z-y-x",
      sector_id: 123,
      checksum: "abxyz"
    }
  end

  test "aaaaa-bbb-z-y-x-123[abxyz] is a real room" do
    real? = "aaaaa-bbb-z-y-x-123[abxyz]"
    |> Room.from_string
    |> Room.real?

    assert real?
  end

  test "a-b-c-d-e-f-g-h-987[abcde] is a real room" do
    real? = " a-b-c-d-e-f-g-h-987[abcde] "
    |> Room.from_string
    |> Room.real?

    assert real?
  end

  test "totally-real-room-200[decoy] is a decoy room" do
    real? = "totally-real-room-200[decoy]"
    |> Room.from_string
    |> Room.real?

    refute real?
  end

  @tag :solutions
  test "Part 1 solution" do
    assert CodeAdvent2016.Day04.PartOne.run == 173787
  end

end