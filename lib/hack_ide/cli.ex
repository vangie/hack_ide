defmodule HackIde.CLI do

  def main(_) do
    :user_drv.start([:"tty_sl -c -e", tty_args()])
    :timer.sleep :infinity
  end

  defp tty_args do
    {__MODULE__, :start, []}
  end

  def start do
    spawn_link &HackIde.start/0
  end

end
