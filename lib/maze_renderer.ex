defmodule MazeRenderer do
  @behaviour Ratatouille.App
  import Ratatouille.View
  import Ratatouille.Constants, only: [key: 1]

  @moduledoc false

  @arrow_up key(:arrow_up)
  @arrow_down key(:arrow_down)
  @arrow_left key(:arrow_left)
  @arrow_right key(:arrow_right)
  @enter key(:enter)

  def init(%{window: window}) do
    %{
      height: window.height - 2,
      width: window.width - 2,
      page: :maze_select,
      mazes: File.ls!("lib/mazes"),
      maze_cursor: 1,
      selected_maze: "",
      board: nil
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

        %{
          model
          | selected_maze: selected_maze,
            page: :maze_interaction,
            board: Board.new("lib/mazes/#{selected_maze}")
        }

      _ ->
        model
    end
  end

  def update(
        %{
          page: :maze_interaction,
          board: board
        } = model,
        msg
      ) do
    case msg do
      {:event, %{key: key}} when key in [@arrow_up, @arrow_down, @arrow_left, @arrow_right] ->
        direction =
          case key do
            @arrow_up -> :up
            @arrow_down -> :down
            @arrow_left -> :left
            @arrow_right -> :right
          end

        %{model | board: Position.move(board, direction)}

      _ ->
        model
    end
  end

  def update(model, _msg) do
    model
  end

  def render(%{
        page: :maze_select,
        maze_cursor: maze_cursor,
        mazes: mazes
      }) do
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

  def render(
        %{
          page: :maze_interaction,
          selected_maze: maze,
          board: board
        } = model
      ) do
    view do
      panel(
        title: "Selected maze: #{maze}",
        height: :fill,
        padding: 0
      ) do
        canvas(height: model.height, width: model.width) do
          render_board(board)
        end
      end
    end
  end

  def render_board(board) do
    board
    |> Enum.filter(fn {k, _v} -> k !== :player_at end)
    |> Enum.map(fn
      {coordinate, %Cell{occupied: true}} ->
        canvas_cell(x: coordinate.x, y: coordinate.y, char: "P")

      {coordinate, cell} ->
        cell_character =
          case cell.type do
            :exit -> "X"
            :corridor -> " "
            :start -> "S"
            :border -> "*"
          end

        canvas_cell(x: coordinate.x, y: coordinate.y, char: cell_character)
    end)
  end
end
