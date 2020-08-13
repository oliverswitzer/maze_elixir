defmodule Board do
  def new(maze_file) do
    {:ok, body} = File.read(maze_file)

    rows = String.split(body, "\n")

    rows
      |> Enum.with_index
      |> Enum.reduce(%{}, fn {row, y}, acc ->
        [_ | characters] = String.split(row, "") |>  Enum.drop(-1)

        coordinates = characters
          |> Enum.with_index
          |> Enum.reduce(%{}, fn {char, x}, acc ->
            cell = case char do
              "*" -> %Cell{type: :border}
              " " -> %Cell{type: :corridor}
              "E" -> %Cell{type: :exit}
              "s" -> %Cell{type: :start}
              _   -> raise "Invalid maze file"
            end

            place_cell(acc, cell, x, y)
        end)

        Map.merge(acc, coordinates)
    end)
  end

  def place_cell(board, cell = %Cell{type: :start}, x, y) do
    Map.put(board, :player_at, %Coordinate{x: x, y: y})
     |> Map.put(%Coordinate{x: x, y: y}, %Cell{ cell | occupied_by: :player})
  end

  def place_cell(board, cell, x, y) do
    Map.put(board, %Coordinate{x: x, y: y}, cell)
  end
end