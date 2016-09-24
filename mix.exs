defmodule HackIde.Mixfile do
  use Mix.Project

  def project do
    [app: :hack_ide,
     version: "0.1.0",
     elixir: "~> 1.3",
     escript: escript_config,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :gen_state_machine, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      { :gen_state_machine, "~> 1.0.2" },
      { :xxhash, "~> 0.2" },
      { :httpoison, "~> 0.9.1" },
      { :jsx, "~> 2.8" }
    ]
  end

  defp escript_config do
    [
      main_module: HackIde.CLI,
      emu_args: "-noinput"
    ]
  end
end
