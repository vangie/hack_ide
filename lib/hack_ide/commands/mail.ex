defmodule HackIde.Commands.Mail do
  @help "launches email program."
  use HackIde.Commands

  def handle(_args, host, ctx) do
    IO.puts "Launching #{host}'s mail..."
    loop(host, ctx)
  end

  def interactive?, do: true

  defp loop(host, ctx) do
    IO.gets(:stdio, "mail:")
    |> to_string
    |> _parse
    |> _eval(host)
    |> case do
      :exit -> {"", host, ctx}
      output ->
        IO.write output
        loop(host, ctx)
    end
  end

  defp _eval(code, host) do
    case code do
      {:help, _} -> HackIde.Mail.help
      {:ls, _}   -> HackIde.Mail.ls(host)
      {:show, [msg|_]} -> HackIde.Mail.show(host, msg)
      {:show, []} -> HackIde.Mail.show(host, nil)
      {:exit, _} -> :exit
      {:nop, _} -> ""
      {cmd, _} -> "command not found: #{cmd}\n"
      _ -> ""
    end
  end

  defp _parse(code) do
    case code |> String.split(~r{\s+}, trim: true) do
      [cmd | args] -> {String.to_atom(cmd), args}
      [] -> {:nop, []}
    end
  end

end
