
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
              "*" -> %Cell{type: :border, occupied_by: nil}
              " " -> %Cell{type: :corridor, occupied_by: nil}
              "E" -> %Cell{type: :exit, occupied_by: nil}
              "s" -> %Cell{type: :start, occupied_by: :player}
              _   -> raise "Invalid maze file"
            end

            Map.put(acc, %Coordinate{x: x, y: y}, cell)
        end)

        Map.merge(acc, coordinates)
    end)
  end
end