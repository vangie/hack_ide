defmodule HackIde do

  alias HackIde.Hosts, as: Hosts
  alias HackIde.Server, as: Server
  alias HackIde.Helpers, as: Helpers
  alias HackIde.Autocomplete, as: Autocomplete

  def start() do
    Helpers.clear()
    set_expand_fun()
    Hosts.start()
    Server.start()
  end


  defp set_expand_fun do
    _ = :io.setopts(Process.group_leader, expand_fun: &Autocomplete.expand(&1))
  end

end
