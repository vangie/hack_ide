defmodule HackIde.Server do

  alias HackIde.Hosts, as: Hosts
  alias HackIde.Evaluator, as: Evaluator

  def start() do
    IO.puts """
    Local System Startup
    Bootup Complete
    Version 0.0.1
    2016 all rights reserved
    type 'help' for help
    """
    evaluator = start_evaluator()
    loop(evaluator)
  end

  defp start_evaluator do
    evaluator = :proc_lib.start(Evaluator, :init, [self()])
    Process.put(:evaluator, evaluator)
    evaluator
  end

  defp loop(evaluator) do
    self_pid = self()

    spawn(fn -> io_get(self_pid) end)
    |> wait_input(evaluator)
  end

  defp exit_loop(evaluator, done? \\ true) do
    Process.delete(:evaluator)
    if done? do
      send(evaluator, {:done, self()})
    end
    :ok
  end

  defp wait_input(input, evaluator) do
    receive do
      {:input, ^input, code} when is_binary(code) ->
        send evaluator, {:eval, self(), code}
        wait_eval(evaluator)
      {:input, ^input, {:error, :interrupted}} ->
        io_error "** (EXIT) interrupted"
        loop(evaluator)
      {:input, ^input, :eof} ->
        exit_loop(evaluator)
      {:input, ^input, {:error, :terminated}} ->
        exit_loop(evaluator)
    end
  end

  defp wait_eval(evaluator) do
    receive do
      {:evaled, ^evaluator, result} ->
        case result do
          {:output, output} ->
            IO.write output
          {:apply, module, args} ->
            {output, _, _} = apply(module, :apply, args)
            IO.write output
        end
        loop(evaluator)
      {:EXIT, _pid, :interrupt} ->
        # User did ^G while the evaluator was busy or stuck
        io_error "** (EXIT) interrupted"
        Process.delete(:evaluator)
        Process.exit(evaluator, :kill)
        evaluator = start_evaluator()
        loop(evaluator)
    end
  end

  defp io_error(result) do
    IO.puts :stdio, IEx.color(:eval_error, result)
  end

  defp io_get(pid) do
    code = IO.gets(:stdio, prompt())
    send pid, {:input, self(), code|>to_string}
  end

  defp prompt() do
    { host, _ } = Hosts.current()
    "#{host}> "
  end

end
