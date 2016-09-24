defmodule HackIde.Commands.HelpTest do
  use ExUnit.Case

  import HackIde.Commands.Help, only: [handle: 3, help: 0]

  test "help" do
    assert help() == "display a list of system commands."
  end

  test "handle localhost" do
    {result, _, _} = handle([], :localhost, %{})

    assert result == """
    'localhost' help menu:
      help\tdisplay a list of system commands.
      ls\tlist directory contents.
      pwd\tprint name of current/working directory.
      cd\tchange the shell working directory.
      cat\tconcatenate files and print on the standard output.
      exit\tlogout and shutdown your localhost.
      hack\thacking some host.
    """
  end
end
