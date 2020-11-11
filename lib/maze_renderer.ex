defmodule MazeRenderer do
  @behaviour Ratatouille.App
  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1]

  @moduledoc false

  @arrow_up key(:arrow_up)
  @arrow_down key(:arrow_down)
  @enter key(:enter)

  def init(%{window: window}) do
    %{
      height: window.height - 2,
      width: window.width - 2,
      page: :maze_select,
      mazes: File.ls!("lib/mazes"),
      maze_cursor: 1,
      selected_maze: ""
    }
  end

  def update(
        %{
          page: :maze_select,
          maze_cursor: maze_cursor,
          mazes: mazes
        } = model,
        msg
      ) do
    case msg do
      {:event, %{key: key}} when key in [@arrow_up, @arrow_down] ->
        new_cursor =
          case key do
            @arrow_up -> maze_cursor - 1
            @arrow_down -> maze_cursor + 1
          end

        %{model | maze_cursor: new_cursor}
      {:event, %{key: key}} when key === @enter ->
        selected_maze =
          mazes
          |> Enum.at(maze_cursor - 1)

        %{model | selected_maze: selected_maze, page: :maze_interaction}
      _ ->
        model
    end
  end

  def update(model, msg) do
    model
  end

  def render(
        %{
          page: :maze_select,
          maze_cursor: maze_cursor,
          mazes: mazes
        } = model
      ) do
    view do
      label(content: "Please select a maze:")

      mazes
      |> Enum.with_index()
      |> Enum.map(fn {file, i} ->
        current_maze = i + 1

        if(current_maze === maze_cursor) do
          label(content: "--> #{current_maze}) #{file} <--")
        else
          label(content: "#{current_maze}) #{file}")
        end
      end)
    end
  end

  def render(%{page: :maze_interaction, selected_maze: maze}) do
    view do
      label(content: "Selected maze: #{maze}")
    end
  end
end
