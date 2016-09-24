defmodule HackIde.Helpers do
  def clear do
    IO.write [IO.ANSI.home, IO.ANSI.clear]
  end

  def format(charlist, args) when is_list(charlist) do
    _format(charlist, args, [])
  end

  def format(string, args) when is_binary(string) do
    string
    |> to_char_list
    |> format(args)
  end

  defp _format([??, n | tail], args, formated) when ?0 <= n and n <= ?9 do
    _format(tail, args, formated ++ (Enum.at(args, n - ?0)|> to_char_list))
  end

  defp _format([ c | tail], args, formated) do
    _format(tail, args, formated ++ [c])
  end

  defp _format([], _args, formated) do
    formated
  end

end
