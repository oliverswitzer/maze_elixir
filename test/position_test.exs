defmodule PositionTest do
  use ExUnit.Case

  @moduledoc """
  The maze in this test looks like this
  ******
  *    *
  *E s *
  *    *
  ******
  """
  setup do
    board = %{
      :player_at => %Coordinate{x: 3, y: 2},
      %Coordinate{x: 0, y: 0} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 0, y: 1} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 0, y: 2} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 0, y: 3} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 0, y: 4} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 1, y: 0} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 1, y: 1} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 1, y: 2} => %Cell{occupied: false, type: :exit},
      %Coordinate{x: 1, y: 3} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 1, y: 4} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 2, y: 0} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 2, y: 1} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 2, y: 2} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 2, y: 3} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 2, y: 4} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 3, y: 0} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 3, y: 1} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 3, y: 2} => %Cell{occupied: true, type: :start},
      %Coordinate{x: 3, y: 3} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 3, y: 4} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 4, y: 0} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 4, y: 1} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 4, y: 2} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 4, y: 3} => %Cell{occupied: false, type: :corridor},
      %Coordinate{x: 4, y: 4} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 5, y: 0} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 5, y: 1} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 5, y: 2} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 5, y: 3} => %Cell{occupied: false, type: :border},
      %Coordinate{x: 5, y: 4} => %Cell{occupied: false, type: :border}
    }

    %{board: board}
  end

  describe "moving left" do
    test "it will move the player one cell to the left", %{board: board} do
      new_board = Position.move(board, :left)

      assert new_board[%Coordinate{x: 2, y: 2}].occupied
      refute new_board[%Coordinate{x: 3, y: 2}].occupied
    end
  end

  describe "moving up" do
    test "it will move the player one cell up", %{board: board} do
      new_board = Position.move(board, :up)

      assert new_board[%Coordinate{x: 3, y: 1}].occupied
      refute new_board[%Coordinate{x: 3, y: 2}].occupied
    end
  end

  describe "moving down" do
    test "it will move the player one cell down", %{board: board} do
      new_board = Position.move(board, :down)

      assert new_board[%Coordinate{x: 3, y: 3}].occupied
      refute new_board[%Coordinate{x: 3, y: 2}].occupied
    end
  end

  describe "moving right" do
    test "it will move the player one cell to the right", %{board: board} do
      new_board = Position.move(board, :right)

      assert new_board[%Coordinate{x: 4, y: 2}].occupied
      refute new_board[%Coordinate{x: 3, y: 2}].occupied
    end
  end

  describe "borders" do
    test "it will not let the player move through borders", %{board: board} do
      assert board[:player_at] == %Coordinate{x: 3, y: 2}
      assert board[%Coordinate{x: 5, y: 2}].type == :border

      new_board =
        board
        |> Position.move(:right)
        |> Position.move(:right)
        |> Position.move(:right)

      assert new_board[:player_at] == %Coordinate{x: 4, y: 2}
    end
  end

  test "it will update the player coordinate", %{board: board} do
    new_board = Position.move(board, :right)

    assert new_board[:player_at] == %Coordinate{x: 4, y: 2}
  end
end
