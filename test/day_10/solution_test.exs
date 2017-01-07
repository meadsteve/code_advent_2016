defmodule CodeAdvent2016.Day10SolutionTest do
  use ExUnit.Case
  alias CodeAdvent2016.Day10.PartOne
  alias CodeAdvent2016.Day10.Bot

  test "Bot starts with [] chips" do
    bot = Bot.start_link!
    assert Bot.get_chips(bot) == []
  end

  test "Bot takes 1 chip" do
    bot = Bot.start_link!
    |> Bot.give_chip(5)

    assert Bot.get_chips(bot) == [5]
  end

  test "Bot takes 2 chips and sends them away so it's left with []'" do
    bot = Bot.start_link!
    |> Bot.give_chip(5)
    |> Bot.give_chip(3)

    assert Bot.get_chips(bot) == [5, 3]
  end

  test "Bot messages us to give its low chip to the set target" do
    Bot.start_link!
    |> Bot.set_low_target(bot: 2)
    |> Bot.give_chip(5)
    |> Bot.give_chip(3)

    assert_receive {:send, to_bot: 2, value: 3}
  end

  test "Bot messages us to give its high chip to the set target" do
    Bot.start_link!
    |> Bot.set_high_target(bot: 10)
    |> Bot.give_chip(5)
    |> Bot.give_chip(3)

    assert_receive {:send, to_bot: 10, value: 5}
  end

  @tag :solutions
  test "Part 1 solution" do
    assert PartOne.run == ""
  end

end