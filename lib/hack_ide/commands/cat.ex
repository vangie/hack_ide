defmodule HackIde.Commands.Cat do
  @help "concatenate files and print on the standard output."
  use HackIde.Commands

  alias HackIde.FileSystem, as: FS

  def handle(args, host, ctx) do
    output = case args do
      [path | _] -> FS.cat(ctx.fs, path, ctx.pwd)
      [] -> "error: missing file name\n"
    end

    {output, host, ctx}
  end

end
