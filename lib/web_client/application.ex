defmodule WebClient.Application do
  use Application

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: WebClient.Router,
        # plug: WebClient.Endpoint,
        options: [port: Application.get_env(:tictactoe, :port)]
      )
    ]

    opts = [strategy: :one_for_one, name: TicTacToe.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
