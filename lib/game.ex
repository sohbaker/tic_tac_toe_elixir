defmodule Game do
  defstruct [:board, :player_one, :player_two, :current_player]

  def new(player_one, player_two) do
    game = %Game{
      player_one: player_one,
      player_two: player_two,
      board: Board.grid()
    }

    %Game{game | current_player: game.player_one}
  end

  def start(%Game{board: board, current_player: player} = game) do
    move = Player.get_move(player)
    updated = Player.update_player(player)
    new_board = Board.mark_board(board, move, player.mark)
    new_player = toggle_player(game, player)
    %Game{game | board: new_board, current_player: new_player, player_one: updated}
  end

  def play_turn(game) do
    move = Player.get_move(game.current_player)
    updated = Player.update_player(game.current_player)
    new_board = Board.mark_board(game.board, move, game.current_player.mark)
    new_player = toggle_player(game, game.current_player)
    %Game{game | board: new_board, current_player: new_player, player_two: updated}
  end

  def toggle_player(game, player) do
    if player.mark == game.player_one.mark do
      game.player_two
    else
      game.player_one
    end
  end

  def over?(game, board) do
    Board.tie?(board, game.player_one.mark, game.player_two.mark) ||
      Board.win?(board, game.player_one.mark) || Board.win?(board, game.player_two.mark)
  end
end
