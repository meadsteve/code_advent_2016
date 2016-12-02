defmodule CodeAdvent2016.Day01.SolutionTest do
  use ExUnit.Case
  doctest CodeAdvent2016.Day01

  alias CodeAdvent2016.Day01.Location

  test "Rotating right works" do
    north_facing = %Location{direction: :north}
    east_facing = %Location{direction: :east}
    south_facing = %Location{direction: :south}
    west_facing = %Location{direction: :west}

    assert CodeAdvent2016.Day01.rotate(north_facing, "R") == east_facing
    assert CodeAdvent2016.Day01.rotate(east_facing, "R") == south_facing
    assert CodeAdvent2016.Day01.rotate(south_facing, "R") == west_facing
    assert CodeAdvent2016.Day01.rotate(west_facing, "R") == north_facing
  end

  test "Rotating left works" do
    north_facing = %Location{direction: :north}
    east_facing = %Location{direction: :east}
    south_facing = %Location{direction: :south}
    west_facing = %Location{direction: :west}

    assert CodeAdvent2016.Day01.rotate(north_facing, "L") == west_facing
    assert CodeAdvent2016.Day01.rotate(west_facing, "L") == south_facing
    assert CodeAdvent2016.Day01.rotate(south_facing, "L") == east_facing
    assert CodeAdvent2016.Day01.rotate(east_facing, "L") == north_facing
  end

end