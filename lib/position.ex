defmodule Position do
  def move(board, direction) when direction in [:left, :right, :up, :down] do
    player_coordinate = board[:player_at]
    player_cell = board[player_coordinate]

    new_coord =
      case direction do
        :left -> %Coordinate{x: player_coordinate.x - 1, y: player_coordinate.y}
        :right -> %Coordinate{x: player_coordinate.x + 1, y: player_coordinate.y}
        :up -> %Coordinate{x: player_coordinate.x, y: player_coordinate.y - 1}
        :down -> %Coordinate{x: player_coordinate.x, y: player_coordinate.y + 1}
      end

    update_board(board, new_coord, player_coordinate, player_cell)
    |> Map.put(:player_at, new_coord)
  end

  defp update_board(board, new_coord, old_coord, old_cell) do
    new_cell = %Cell{board[new_coord] | occupied: true}

    board
    |> Map.put(new_coord, new_cell)
    |> Map.put(old_coord, %Cell{old_cell | occupied: false})
  end
end
