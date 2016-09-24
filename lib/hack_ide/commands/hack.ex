defmodule HackIde.Commands.Hack do
  @help "hacking some host."
  use HackIde.Commands

  def interactive?, do: true

  alias HackIde.Hosts
  alias HackIde.User

  def handle(["gateway" | _tail ], :jumper, ctx) do
    IO.puts """
    Establishing a connection to the Gateway System...
    Connection Established.
    Log in with your Gateway account
    """
    username = IO.gets("username:") |> to_string |> String.trim
    password = IO.gets("password:") |> to_string |> String.trim

    unless User.auth(username, password) do
      {"hostname or password is wrong.\n", :jumper, ctx}
    else
      {host, ctx} = Hosts.login(:gateway)
      {"\nWelcome #{username}!\n`login <username>` to your host.\n", host, ctx}
    end

  end

  def handle(_, host, ctx) do
    {"usage: hack <host>\n", host, ctx}
  end

end
