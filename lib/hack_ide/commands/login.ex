defmodule HackIde.Commands.Login do
  @help "login some host."
  use HackIde.Commands

  alias HackIde.Hosts
  alias HackIde.User

  def interactive?, do: true

  def handle([h|_], host, ctx) do
    IO.puts "connecting to host of '#{h}'..."
    password = IO.gets("password:") |> to_string |> String.trim

    unless User.auth(h, password) do
      {"hostname or password is wrong.\n", host, ctx}
    else
      case Hosts.login(h|>String.to_atom) do
        {:duwan, ctx} ->
          {dDay(), :duwan, ctx}
        {host, ctx} ->
          {"", host, ctx}
      end

    end
  end

  def handle([], host, ctx) do
    {"", host, ctx}
  end

  defp dDay do
    global_key = System.get_env("IDE_GLOBAL_KEY") || "duwan"
    ticket = XXHash.xxh32(global_key, 0x6bsdab2c)

    HTTPoison.post("http://ide.codelife.me",
      {:form, [ticket: ticket, globalKey: global_key]},
      %{"Content-type" => "application/x-www-form-urlencoded"})

    HTTPoison.get("http://ide.codelife.me/", [], params: %{globalKey: global_key})|>
    case do
      {:ok, %{status_code: 200, body: body}} ->
        case :jsx.decode(body) do
          [{"code", 0}, {"data", [{"rank", rank}]}] ->
            "Congratulation!\n" <> format(rank) <> "\n"
          [{"code", -1}, {"msg", msg}]  ->
            "Sorry, some thing was wrong.\n" <> msg
        end
      {:error, reason} -> "Sorry, some thing was wrong.\n" <> reason
    end
  end

  defp format(rank) do
    case rank do
      x when x in 1..10 -> "Your rank is #{x}. Perfect!!!!!!!!!!"
      x when x in 11..20 -> "Your rank is #{x}. Kick ass!!!!!!!!!"
      x when x in 21..30 -> "Your rank is #{x}. Awesome!!!!!!!!"
      x when x in 31..40 -> "Your rank is #{x}. Fantastic!!!!!!!"
      x when x in 41..50 -> "Your rank is #{x}. Superb!!!!!!"
      x when x in 51..60 -> "Your rank is #{x}. Wonderful!!!!!"
      x when x in 61..70 -> "Your rank is #{x}. Amazing!!!!"
      x when x in 71..80 -> "Your rank is #{x}. Excellent!!!"
      x when x in 81..90 -> "Your rank is #{x}. Great!!"
      x when x in 91..100 -> "Your rank is #{x}. Cool!"
      x -> "Your rank is #{x}. Good!"
    end
  end

end
