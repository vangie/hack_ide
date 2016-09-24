defmodule HackIde.Helpers.Test do
  use ExUnit.Case

  import HackIde.Helpers, only: [format: 2]

  test "format" do
    assert format("exit\tlogout and shutdown your ?0", [:localhost]) == 'exit\tlogout and shutdown your localhost'
  end
end
