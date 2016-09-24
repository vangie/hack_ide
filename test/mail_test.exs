defmodule HackIde.Mail.Test do
  use ExUnit.Case

  import HackIde.Mail

  test "ls" do
    assert ls(:localhost) == "List of Messages\n\talex\t<sent>\n\tcathy\t<sent>\n"
  end

  test "show" do
    assert show(:localhost, "alex") == "sfdsdf\n"
  end

end
