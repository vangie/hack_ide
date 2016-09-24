defmodule HackIde.Commands.Pwd do
  @help "print name of current/working directory."
  use HackIde.Commands

  def handle(_args, host, ctx) do
    {ctx.pwd <> "\n", host, ctx}
  end

end
