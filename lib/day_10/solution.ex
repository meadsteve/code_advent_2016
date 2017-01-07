defmodule CodeAdvent2016.Day10.Bot do
  use GenServer

  def start_link!(bot_number) do
    {:ok, bot} = start_link(bot_number)
    bot_number
  end

  def start_link(bot_number) do
    GenServer.start_link(__MODULE__, %{}, name: via_tuple(bot_number))
  end

  def give_chip(bot_number, value) do
    GenServer.cast(via_tuple(bot_number), {:give_chip, value})
    bot_number
  end

  def get_chips(bot_number) do
    GenServer.call(via_tuple(bot_number), :get_chips)
  end

  def set_low_target(bot_number, target: target) do
    GenServer.cast(via_tuple(bot_number), {:set_low_target, target})
    bot_number
  end

  def set_high_target(bot_number, target: target) do
    GenServer.cast(via_tuple(bot_number), {:set_high_target, target})
    bot_number
  end

  # SERVER

  def init(bot_state) do
    {:ok, bot_state}
  end

  def handle_cast({:give_chip, value}, bot_state) do
    updated_state = Map.update(bot_state, :values, [value], fn [other] -> [other, value] end)
    case Map.get(updated_state, :values) do
      [a, b] -> send_chips(bot_state, [a, b])
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

  defp send_chips(bot_data, [a, b]) do
    give_chip(Map.get(bot_data, :low), min(a, b))
    give_chip(Map.get(bot_data, :high), max(a, b))
  end

  defp via_tuple(bot_number) do
    {:via, CodeAdvent2016.Day10.BotRegistry, {:bot_number, bot_number}}
  end


end

defmodule CodeAdvent2016.Day10.BotSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :bot_supervisor)
  end

  def start_bot!(bot_number) do
    {:ok, bot} = Supervisor.start_child(:bot_supervisor, [bot_number])
    bot
  end

  def start_bot(bot_number) do
    Supervisor.start_child(:bot_supervisor, [bot_number])
  end

  def init(_) do
    children = [
      worker(CodeAdvent2016.Day10.Bot, [])
    ]
    supervise(children, strategy: :simple_one_for_one)
  end
end

defmodule CodeAdvent2016.Day10.BotRegistry do
  use GenServer

  # API

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def whereis_name(bot_number) do
    GenServer.call(__MODULE__, {:whereis_bot, bot_number})
  end

  def register_name(bot_number, pid) do
    GenServer.call(__MODULE__, {:register_bot, bot_number, pid})
  end

  def unregister_name(bot_number) do
    GenServer.cast(__MODULE__, {:unregister_bot, bot_number})
  end

  def send(bot_number, message) do
    case whereis_name(bot_number) do
      :undefined ->
        {:badarg, {bot_number, message}}
      pid ->
        Kernel.send(pid, message)
        pid
    end
  end

  # SERVER
  def init(_) do
    {:ok, Map.new}
  end

  def handle_call({:whereis_bot, bot_number}, _from, state) do
    {:reply, Map.get(state, bot_number, :undefined), state}
  end

  def handle_call({:register_bot, bot_number, pid}, _from, state) do
    case Map.get(state, bot_number) do
      nil ->
        {:reply, :yes, Map.put(state, bot_number, pid)}
      _ ->
        {:reply, :no, state}
    end
  end

  def handle_cast({:unregister_bot, bot_number}, state) do
    {:noreply, Map.delete(state, bot_number)}
  end
end


defmodule CodeAdvent2016.Day10.PartOne do
  @file_path "lib/day_10/input.txt"
  alias CodeAdvent2016.Day10.BotSupervisor
  alias CodeAdvent2016.Day10.BotRegistry
  alias CodeAdvent2016.Day10.Bot

  def lines() do
    @file_path
    |> File.stream!()
  end

  def run() do
    {:ok, _} = BotRegistry.start_link()
    {:ok, _} = BotSupervisor.start_link()

    lines
    |> Enum.each(&run_line/1)
  end

  defp run_line("bot" <> instruction) do
    data = Regex.named_captures(~r/(?<bot>[0-9]+) gives low to bot (?<low>[0-9]+) and high to bot (?<high>[0-9]+)/i, instruction)
    BotSupervisor.start_bot(String.to_integer(data["bot"]))
    Bot.set_low_target(String.to_integer(data["bot"]), target: String.to_integer(data["low"]))
    Bot.set_high_target(String.to_integer(data["bot"]), target:  String.to_integer(data["high"]))
  end
end