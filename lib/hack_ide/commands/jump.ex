defmodule HackIde.Commands.Jump do
  @help "login to jumper host."
  use HackIde.Commands

  alias HackIde.Hosts, as: Hosts

  def handle(_args, :localhost, _ctx) do
    {host, ctx} = Hosts.login(:jumper)
    {"", host, ctx}
  end

end
