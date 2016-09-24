defmodule HackIde.Commands.Cd do
  @help "change the shell working directory."
  use HackIde.Commands

  alias HackIde.FileSystem, as: FS
  alias HackIde.Hosts
  alias HackIde.FileSystem.File
  alias HackIde.FileSystem.Folder

  def handle(args, host, ctx) do
    pwd = case args do
      [path | _] ->
        FS.expand(path, ctx.pwd)
      [] ->
        FS.expand("~", ctx.pwd)
    end

    FS.locate(pwd, ctx.fs)
    |> _cd(pwd, host, ctx)
  end

  defp _cd(%Folder{} = _, pwd, _, _) do
    {host, ctx} = Hosts.cd(pwd)
    {"", host, ctx}
  end

  defp _cd(%File{} = _, pwd, host, ctx) do
    {"#{pwd} is not a directory\n", host, ctx}
  end

  defp _cd(:not_found, _pwd, host, ctx) do
    {"No such directory\n", host, ctx}
  end

end
