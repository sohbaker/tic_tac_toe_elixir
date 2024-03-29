defmodule Board do
  @naught Mark.naught()
  @cross Mark.cross()
  @winning_lines [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [2, 4, 6], [0, 4, 8]]

  def grid do
    [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def mark_board(board, position, mark) do
    List.replace_at(board, position - 1, mark)
  end

  def available_moves(board) do
    Enum.filter(board, fn x -> x != @naught && x != @cross end)
  end

  def valid?(board, position) do
    empty_space?(board, position) &&
      valid_digit?(board, position)
  end

  def over?(board) do
    tie?(board) || win?(board)
  end

  def full?(board) do
    Enum.all?(board, fn x -> x == @naught || x == @cross end)
  end

  def win?(board) do
    check_for_win(board, @naught) || check_for_win(board, @cross)
  end

  def tie?(board) do
    Board.full?(board) && !Board.win?(board)
  end

  def get_winning_mark(board) do
    cond do
      check_for_win(board, @naught) == true ->
        @naught
      check_for_win(board, @cross) == true ->
        @cross
      true ->
        nil
    end
  end

  defp check_for_win(board, player_mark) do
    Enum.member?(check_lines(board, player_mark), true)
  end

  defp check_lines(board, player_mark) do
    for winning_line <- @winning_lines do
      Enum.all?(winning_line, fn x -> Enum.at(board, x) == player_mark end)
    end
  end

  defp empty_space?(board, position) do
    Enum.at(board, position - 1) != @naught &&
      Enum.at(board, position - 1) != @cross
  end

  defp valid_digit?(board, position) do
    position > 0 && position <= length(board)
  end
end
