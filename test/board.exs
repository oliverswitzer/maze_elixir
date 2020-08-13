defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  setup do
    maze = """
    ***
    *Es
    ***
    """ |> String.trim

    File.write("test/sample_maze.txt", maze)

    on_exit fn ->
      if File.exists?("test/sample_maze.txt"), do: File.rm("test/sample_maze.txt")
    end
  end

  describe "new" do
    test "creates grid of cells with the correct start and exit" do
      result = Board.new("test/sample_maze.txt")

      number_of_cells = Enum.count(Map.keys(result))
      assert number_of_cells == 9

      start_coord = result[%Coordinate{x: 2, y: 1}]
      assert start_coord == %Cell{type: :start, occupied_by: :player}

      end_coord = result[%Coordinate{x: 1, y: 1}]
      assert end_coord == %Cell{type: :exit, occupied_by: nil}
    end
  end
end
