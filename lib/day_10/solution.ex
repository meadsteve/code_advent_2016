defmodule CodeAdvent2016.Day10.Bot do
  use GenServer

  def start_link! do
    {:ok, bot} = start_link(self())
    bot
  end

  def start_link(owner) do
    GenServer.start_link(__MODULE__, %{:owner => owner})
  end

  def give_chip(bot, value) do
    GenServer.cast(bot, {:give_chip, value})
    bot
  end

  def get_chips(bot) do
    GenServer.call(bot, :get_chips)
  end

  def set_low_target(bot, bot: bot_number) do
    GenServer.cast(bot, {:set_low_target, bot_number})
    bot
  end

  def set_high_target(bot, bot: bot_number) do
    GenServer.cast(bot, {:set_high_target, bot_number})
    bot
  end

  # SERVER

  def init(bot_state) do
    {:ok, bot_state}
  end

  def handle_cast({:give_chip, value}, bot_state) do
    updated_state = Map.update(bot_state, :values, [value], fn [other] -> [other, value] end)
    case Map.get(updated_state, :values) do
      [a, b] -> send_values(bot_state, [a, b])
      _      -> :do_nothing
    end
    {:noreply, updated_state}
  end

  def handle_cast({:set_low_target, bot_number}, bot_state) do
    {:noreply, Map.put_new(bot_state, :low, bot_number)}
  end

  def handle_cast({:set_high_target, bot_number}, bot_state) do
    {:noreply, Map.put_new(bot_state, :high, bot_number)}
  end

  def handle_call(:get_chips, _from, bot_state) do
    {:reply, Map.get(bot_state, :values, []), bot_state}
  end

  defp send_values(bot_data, [a, b]) do
    send Map.get(bot_data, :owner),
         {:send, to_bot: Map.get(bot_data, :low), value: min(a, b)}
    send Map.get(bot_data, :owner),
         {:send, to_bot: Map.get(bot_data, :high), value: max(a, b)}
  end

end

defmodule CodeAdvent2016.Day10.PartOne do
  @file_path "lib/day_10/input.txt"

  def lines() do
    @file_path
    |> File.read!()
  end

  def run() do

  end
end