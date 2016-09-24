defmodule HackIde.Commands.Ls do
  @help "list directory contents."
  use HackIde.Commands

  alias HackIde.FileSystem, as: FS

  def handle(args, host, ctx) do
    output = case args do
      [path | _] -> FS.ls(ctx.fs, path, ctx.pwd)
      [] -> FS.ls(ctx.fs, ".", ctx.pwd)
    end
    {output, host, ctx}
  end

end
