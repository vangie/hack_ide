defmodule HackIde.Commands.Exit do
  @help "logout and shutdown your ?0."
  use HackIde.Commands

  alias HackIde.Hosts, as: Hosts

  def handle(_args, _host, _ctx) do
    case Hosts.logout do
      {:ok, host, ctx} -> {"", host, ctx}
      {:shutdown, _, _} ->
        IO.puts "bye!"
        System.halt(0)
    end
  end

end
