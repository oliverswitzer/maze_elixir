defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  setup do
    maze =
      """
      ***
      *Es
      ***
      """
      |> String.trim()

    File.write("test/sample_maze.txt", maze)

    on_exit(fn ->
      if File.exists?("test/sample_maze.txt"), do: File.rm("test/sample_maze.txt")
    end)
  end

  describe "new" do
    test "creates grid of cells with the correct start and exit" do
      result = Board.new("test/sample_maze.txt")

      number_of_cells = result |> Enum.count(fn {k, _v} -> k !== :player_at end)
      assert number_of_cells == 9

      start_coord = result[%Coordinate{x: 2, y: 1}]
      assert start_coord == %Cell{type: :start, occupied: true}

      end_coord = result[%Coordinate{x: 1, y: 1}]
      assert end_coord == %Cell{type: :exit, occupied: false}
    end
  end
end
