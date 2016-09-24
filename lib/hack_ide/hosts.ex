defmodule HackIde.Hosts.Context do
  alias HackIde.FileSystem.Folder, as: Folder
  defstruct jumper: nil, home: "/root", pwd: "/root", fs: %Folder{}
  @type t :: %__MODULE__{jumper: {atom, __MODULE__.t}, home: String.t, pwd: String.t, fs: Folder.t }
end

defmodule HackIde.Hosts do
  use GenStateMachine

  alias HackIde.Hosts.Context, as: HostCtx
  alias HackIde.FileSystem, as: FS

  def start() do
    GenStateMachine.start_link(__MODULE__, {:localhost, ctx(:localhost)}, name: :hosts)
  end

  def current do
    GenStateMachine.call(:hosts, :current)
  end

  def cd(path) do
    GenStateMachine.call(:hosts, {:cd, path})
  end

  def login(host, ctx \\ nil) do
    ctx  = ctx || ctx(host)
    GenStateMachine.call(:hosts, {:login, host, ctx})
  end

  def logout do
    GenStateMachine.call(:hosts, :logout)
  end

  defp ctx(host) do
    case host do
      host -> %HostCtx{ fs: FS.root(host)}
    end
  end


  # Callbacks

  def init({state, ctx}) do
    :elixir_config.put(:home, ctx.home)
    {:ok, state, ctx}
  end

  def handle_event({:call, from}, :current, host, ctx) do
    {:next_state, host, ctx, [{:reply, from, {host, ctx}}]}
  end

  def handle_event({:call, from}, {:cd, path}, host, ctx) do
    newCtx = put_in(ctx.pwd, path)
    {:next_state, host , newCtx, [{:reply, from, {host, newCtx}}]}
  end

  def handle_event({:call, from}, {:login, newHost, newCtx }, host, ctx) do
    :elixir_config.put(:home, newCtx.home)
    newCtx = put_in(newCtx.jumper, {host, ctx})
    {:next_state, newHost, newCtx, [{:reply, from, {newHost, newCtx}}]}
  end

  def handle_event({:call, from}, :logout, host, ctx) do
    case ctx.jumper do
      {host, ctx} ->
        :elixir_config.put(:home, ctx.home)
        {:next_state, host, ctx, [{:reply, from, {:ok, host, ctx}}]}
      nil ->
        {:next_state, host, ctx, [{:reply, from, {:shutdown, host, ctx}}]}
    end
  end
end
