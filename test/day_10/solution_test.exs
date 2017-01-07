defmodule CodeAdvent2016.Day10PartsTest do
  use ExUnit.Case
  alias CodeAdvent2016.Day10.Bot
  alias CodeAdvent2016.Day10.BotSupervisor
  alias CodeAdvent2016.Day10.BotRegistry

  setup do
    {:ok, _bot_registry} = BotRegistry.start_link
    :ok
  end

  test "Bot starts with [] chips" do
    bot = Bot.start_link!(1)
    assert Bot.get_chips(bot) == []
  end

  test "Bot takes 1 chip" do
    bot = Bot.start_link!(1)
    |> Bot.give_chip(5)

    assert Bot.get_chips(bot) == [5]
  end

  test "Bot messages 2 to give its low chip to the set target" do
    Bot.start_link!(2)

    Bot.start_link!(1)
    |> Bot.set_low_target(target: 2)
    |> Bot.give_chip(5)
    |> Bot.give_chip(3)

    Process.sleep 100
    assert Bot.get_chips(2) == [3]
  end

  test "Bot messages us to give its high chip to the set target" do
    Bot.start_link!(10)

    Bot.start_link!(1)
    |> Bot.set_high_target(target: 10)
    |> Bot.give_chip(5)
    |> Bot.give_chip(3)

    Process.sleep 100
    assert Bot.get_chips(10) == [5]
  end

  test "Bots can be started by a supervisor" do
    {:ok, _} = BotSupervisor.start_link()

    BotSupervisor.start_bot!(1)
    BotSupervisor.start_bot!(2)

    Bot.give_chip(1, 5)
    Bot.give_chip(2, 3)

    assert Bot.get_chips(1) == [5]
    assert Bot.get_chips(2) == [3]
  end
end

defmodule CodeAdvent2016.Day10SolutionTest do
  use ExUnit.Case
  alias CodeAdvent2016.Day10.PartOne
  @tag :solutions
  test "Part 1 solution" do
    assert PartOne.run == ""
  end

end