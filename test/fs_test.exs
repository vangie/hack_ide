defmodule HackIde.FileSystemTest do
  use ExUnit.Case

  import HackIde.FileSystem

  test "ls /root" do
    result = root(:localhost) |> ls("/root", "/root")

    assert result == "drwxrwxr-x\t4096\t./\ndrwxrwxr-x\t4096\t../\n-rw-rw-r--\t1k\treadme\n"
  end

  test "ls /root/readme" do
    result = root(:localhost) |> ls("/root/readme", "/root")

    assert result == "-rw-rw-r--\t1k\treadme\n"
  end

  test "cat /root" do
    result = root(:localhost) |> cat("/root", "/root")

    assert result == "drwxrwxr-x\t4096\t./\ndrwxrwxr-x\t4096\t../\n-rw-rw-r--\t1k\treadme\n"
  end

  test "cat /root/readme" do
    result = root(:localhost) |> cat("/root/readme", "/root")

    assert result == """
    I'm glad you decided to accept my offer. Trust me, I'll make it worth your while. By now the hack routine should be installed on your local system; just type 'hack coding' to start it up.

    Your Employer
    """
  end


end
