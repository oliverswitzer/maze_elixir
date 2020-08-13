defmodule Cli do
  def get_maze do
    IO.puts "Here are the available maze files"
    {:ok, files} = File.ls "lib/mazes"

    Enum.with_index(files)
    |> Enum.each fn {file, i} -> IO.puts "#{i + 1}) #{file}" end

    { maze_file_index, _} = IO.gets("Please select a maze by number: ") |> Integer.parse

    IO.inspect maze_file_index
    selected_file = Enum.at(files, maze_file_index - 1)
    full_path_file = "lib/mazes/#{selected_file}"

    { :ok, maze } = File.read(full_path_file)

    IO.puts "You selected #{selected_file}. Here's what it looks like:"
    IO.puts maze

    { :ok, full_path_file}
  end
end