defmodule TicTacToe.MixProject do
  use Mix.Project

  def project do
    [
      app: :tictactoe,
      version: "0.1.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      escript: escript(),
      deps: deps()
    ]
  end

  def escript do
    [main_module: CLI.EntryPoint]
  end

  def application do
    [
      extra_applications: [:logger, :plug_cowboy],
      mod: {WebServer.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.1.0"},
      {:poison, "~> 3.1"}
    ]
  end
end
