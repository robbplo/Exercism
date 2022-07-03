defmodule StateOfTicTacToe do
  @doc """
  Determine the state a game of tic-tac-toe where X starts.
  """
  @spec game_state(board :: String.t()) :: {:ok, :win | :ongoing | :draw} | {:error, String.t()}
  def game_state(board) do
    state = parse_board(board)

    cond do
      error = game_error(state) -> error
      game_won?(state) -> {:ok, :win}
      move_count(state) == 9 -> {:ok, :draw}
      true -> {:ok, :ongoing}
    end
  end

  @spec parse_board(board :: String.t()) :: list()
  defp parse_board(board) do
    board
    |> String.split()
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  defp total_wins(state) do
    0..2
    |> Enum.map(&win_in_cross?(state, &1))
    |> Enum.filter(&(&1 == true))
    |> Enum.count()
    |> Kernel.+(if win_in_diagonals?(state), do: 1, else: 0)
  end

  defp game_won?(state) do
    total_wins(state) > 0
  end

  defp win_in_cross?(state, index) do
    row = Enum.fetch!(state, index)
    column = Enum.map(state, &Enum.fetch!(&1, index))

    win_in_vector?(row) or win_in_vector?(column)
  end

  defp win_in_diagonals?(state) do
    [
      [d1, _, d5],
      [_, d2, _],
      [d4, _, d3]
    ] = state

    win_in_vector?([d1, d2, d3]) or win_in_vector?([d4, d2, d5])
  end

  defp win_in_vector?(vector) do
    List.to_string(vector) in ["OOO", "XXX"]
  end

  defp move_count(state) do
    player_move_count(state, "X") + player_move_count(state, "O")
  end

  defp player_move_count(state, player) do
    state
    |> List.flatten()
    |> Enum.filter(&(&1 == player))
    |> length()
  end

  defp game_error(state) do
    cond do
      o_started?(state) ->
        {:error, "Wrong turn order: O started"}

      player = player_went_twice(state) ->
        {:error, "Wrong turn order: #{player} went twice"}

      kept_playing?(state) ->
        {:error, "Impossible board: game should have ended after the game was won"}

      true ->
        false
    end
  end

  defp o_started?(state) do
    player_move_count(state, "O") > player_move_count(state, "X")
  end

  defp player_went_twice(state) do
    moves_o = player_move_count(state, "O")
    moves_x = player_move_count(state, "X")

    cond do
      moves_o - moves_x > 0 -> "O"
      moves_x - moves_o > 1 -> "X"
      true -> false
    end
  end

  defp kept_playing?(state) do
    total_wins(state) > 1
  end
end
