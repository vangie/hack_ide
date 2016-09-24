defmodule HackIde.Evaluator do
  alias HackIde.Commands.Server, as: CmdsServer

  def init(server) do
    :proc_lib.init_ack(self())
    CmdsServer.start()
    loop(server)
  end

  defp loop(server) do
    receive do
      {:eval, ^server, code} ->
        result = _eval(code)
        send server, {:evaled, self(), result}
        loop(server)
      {:done, ^server} ->
        :ok
    end
  end

  defp _eval(code) do
    code
    |> _parse
    |> CmdsServer.exec
  end

  defp _parse(code) do
    case code |> String.split(~r{\s+}, trim: true) do
      [cmd | args] -> {String.to_atom(cmd), args}
      [] -> {:nop, []}
    end
  end

end
