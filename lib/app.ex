require IEx;

defmodule App do
  def run do
    {:ok, maze_file } = Cli.get_maze

    board = Board.new(maze_file)

  end
end
