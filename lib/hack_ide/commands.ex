defmodule HackIde.Commands do

  alias HackIde.Helpers, as: Helpers
  alias HackIde.Hosts.Context, as: HostCtx

  @callback handle(list, atom, HostCtx.t) :: String.t

  defmacro __using__(_params) do
    quote do
        @behaviour HackIde.Commands

        def help(args \\ []), do: Helpers.format(@help, args) |> to_string

        def interactive? , do: false

        defoverridable [help: 0, interactive?: 0]
    end
  end

  @default_list [:help, :ls, :pwd, :cd, :cat, :exit]

  def list(:localhost), do: @default_list ++ [:jump]
  def list(:jumper), do: @default_list ++ [:hack]
  def list(:gateway), do: @default_list ++ [:login]
  def list(_), do: @default_list ++ [:login, :mail]

end

defmodule HackIde.Commands.Server do
  use GenServer

  alias HackIde.Commands, as: Cmds
  alias HackIde.Hosts

  def start do
    GenServer.start_link(__MODULE__, Hosts.current(), name: :cmd_server)
  end

  def exec({cmd, args}) do
    GenServer.call(:cmd_server, {cmd, args})
  end

  def apply(apply_args) do
    {output, newHost, newCtx} = apply(Kernel, :apply, apply_args)
    GenServer.cast(:cmd_server, {:after_apply, {newHost, newCtx}})
    {output, newHost, newCtx}
  end

  # callback

  def handle_call({cmd, args}, _from, {host, ctx}) do
    cond do
      Enum.member?(Cmds.list(host), cmd) ->
        cmdName = cmd
        |> to_string
        |> String.capitalize

        cmdModule = Module.concat(HackIde.Commands, cmdName)

        apply_args = [cmdModule, :handle, [args, host, ctx]]

        if apply(cmdModule, :interactive?, []) do
          {:reply, {:apply, __MODULE__, [apply_args]}, {host, ctx}}
        else
          {output, newHost, newCtx} = apply(Kernel, :apply, apply_args)
          {:reply, {:output, output}, {newHost, newCtx}}
        end
      :nop == cmd ->
        {:reply, {:output, ""}, {host, ctx}}
      true ->
        {:reply, {:output, "command not found: #{cmd}\n"}, {host, ctx}}
    end
  end

  def handle_cast({:after_apply, {newHost, newCtx}}, _) do
    {:noreply, {newHost, newCtx}}
  end

end
