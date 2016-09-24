defmodule HackIde.Commands.Help do
  @help "display a list of system commands."
  alias HackIde.Commands, as: Cmds
  use Cmds

  def handle(_args, host, ctx) do
    output = _help(host, Cmds.list(host))
    {output, host, ctx}
  end

  defp _help(host, cmdList) do
    """
    '#{host}' help menu:
    #{_help_block(host, cmdList)}
    """
  end

  defp _help_block(host, cmdList) do
    (for cmd <- cmdList, do: _help_line(host, cmd))
    |> Enum.join("\n")
  end

  defp _help_line(host, cmd) do
    "  #{cmd}\t#{apply(Module.concat(HackIde.Commands, cmd|> to_string |> String.capitalize), :help, [[host]])}"
  end

end
