defmodule CodeAdvent2016.Day01.SolutionTest do
  use ExUnit.Case

  alias CodeAdvent2016.Day01.Location

  test "Rotating right works" do
    north_facing = %Location{direction: :north}
    east_facing = %Location{direction: :east}
    south_facing = %Location{direction: :south}
    west_facing = %Location{direction: :west}

    assert Location.rotate(north_facing, "R") == east_facing
    assert Location.rotate(east_facing, "R") == south_facing
    assert Location.rotate(south_facing, "R") == west_facing
    assert Location.rotate(west_facing, "R") == north_facing
  end

  test "Rotating left works" do
    north_facing = %Location{direction: :north}
    east_facing = %Location{direction: :east}
    south_facing = %Location{direction: :south}
    west_facing = %Location{direction: :west}

    assert Location.rotate(north_facing, "L") == west_facing
    assert Location.rotate(west_facing, "L") == south_facing
    assert Location.rotate(south_facing, "L") == east_facing
    assert Location.rotate(east_facing, "L") == north_facing
  end

  test "Moving North" do
    start = %Location{direction: :north, north: 0}
    five_blocks_north = %Location{direction: :north, north: 5}

    assert Location.move(start, 5) == five_blocks_north
  end

  test "Moving South" do
    start = %Location{direction: :south, north: 3}
    five_blocks_south = %Location{direction: :south, north: -2}

    assert Location.move(start, 5) == five_blocks_south
  end

  test "Moving East" do
    start = %Location{direction: :east, east: 0}
    five_blocks_east = %Location{direction: :east, east: 5}

    assert Location.move(start, 5) == five_blocks_east
  end

  test "Moving West" do
    start = %Location{direction: :west, east: 3}
    five_blocks_west = %Location{direction: :west, east: -2}

    assert Location.move(start, 5) == five_blocks_west
  end

end