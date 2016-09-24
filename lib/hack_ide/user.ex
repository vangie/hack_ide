defmodule HackIde.User do

  @auth [
    %{ username: "duwan", password: "Coding Anytime Anywhere" },
    %{ username: "tanhe123", password: "java1024" },
    %{ username: "tiangao", password: "golang" },
    %{ username: "hackape", password: "coolboy" },
    %{ username: "azurewind", password: "caffeine" },
    %{ username: "hulufei", password: "Hello world" },
    %{ username: "mingshun", password: "homeboy" },
    %{ username: "xm1994", password: "hackmyself" },
    %{ username: "wangziying", password: "111111"}
  ]

  def auth(username, password) do
    Enum.any?(@auth, &(&1.username == username and (&1.password |> String.upcase) == (password |> String.upcase)))
  end

end
