defmodule Game do
  defstruct [:board, :player_x, :player_o, :current_player]

  def new(player_x, player_o) do
    %Game{
      player_x: player_x,
      player_o: player_o,
      board: Board.grid(),
      current_player: player_x,
    }
  end

  def play(game) do
    if over?(game.board, [game.player_x.mark, game.player_o.mark]) do
      show_outcome(game.board, [game.player_x.mark, game.player_o.mark])
    else
      take_turn(game)
    end
  end

  defp take_turn(%Game{board: board, current_player: current} = game) do
    Display.show_board(board)
    game = Player.get_move(current, board)
           |> update_board(game)
           |> toggle_players()
    play(game)
  end

  defp update_board(move, %Game{board: board, current_player: current} = game) do
    new_board = Board.mark_board(board, move, current.mark)
    %Game{game | board: new_board}
  end

  defp toggle_players(%Game{current_player: current, player_x: player_x, player_o: player_o} = game) do
    updated = Player.update_player(current)
    if updated.mark == player_x.mark do
      %Game{game | current_player: player_o, player_x: updated}
    else
      %Game{game | current_player: player_x, player_o: updated}
    end
  end

  defp over?(board, players) do
    Board.tie?(board, players) || Enum.at(Board.win?(board, players), 0)
  end

  defp show_outcome(board, players) do
    [win, mark] = Board.win?(board, players)
    if win == true do
      Display.show_board(board)
      Display.announce_win(mark) |> Display.print_to_screen
    else
      Display.show_board(board)
      Display.announce_tie |> Display.print_to_screen
    end
  end
end
