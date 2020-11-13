defmodule PositionTest do
  use ExUnit.Case

  setup do
    board = %{
      :player_at => %Coordinate{x: 1, y: 1},
      %Coordinate{x: 0, y: 0} => %Cell{type: :corridor},
      %Coordinate{x: 0, y: 1} => %Cell{type: :corridor},
      %Coordinate{x: 0, y: 2} => %Cell{type: :corridor},
      %Coordinate{x: 1, y: 0} => %Cell{type: :corridor},
      %Coordinate{x: 1, y: 1} => %Cell{type: :corridor, occupied: true},
      %Coordinate{x: 1, y: 2} => %Cell{type: :corridor},
      %Coordinate{x: 2, y: 0} => %Cell{type: :corridor},
      %Coordinate{x: 2, y: 1} => %Cell{type: :corridor},
      %Coordinate{x: 2, y: 2} => %Cell{type: :corridor}
    }

    %{board: board}
  end

  describe "moving left" do
    test "it will move the player one cell to the left", %{board: board} do
      new_board = Position.move(board, :left)

      assert new_board[%Coordinate{x: 0, y: 1}] == %Cell{type: :corridor, occupied: true}
      assert new_board[%Coordinate{x: 1, y: 1}] == %Cell{type: :corridor, occupied: false}
    end
  end

  describe "moving up" do
    test "it will move the player one cell up", %{board: board} do
      new_board = Position.move(board, :up)

      assert new_board[%Coordinate{x: 1, y: 0}] == %Cell{type: :corridor, occupied: true}
      assert new_board[%Coordinate{x: 1, y: 1}] == %Cell{type: :corridor, occupied: false}
    end
  end

  describe "moving down" do
    test "it will move the player one cell down", %{board: board} do
      new_board = Position.move(board, :down)

      assert new_board[%Coordinate{x: 1, y: 2}] == %Cell{type: :corridor, occupied: true}
      assert new_board[%Coordinate{x: 1, y: 1}] == %Cell{type: :corridor, occupied: false}
    end
  end

  describe "moving right" do
    test "it will move the player one cell to the right", %{board: board} do
      new_board = Position.move(board, :right)

      assert new_board[%Coordinate{x: 2, y: 1}] == %Cell{type: :corridor, occupied: true}
      assert new_board[%Coordinate{x: 1, y: 1}] == %Cell{type: :corridor, occupied: false}
    end
  end

  test "it will update the player coordinate", %{board: board} do
    new_board = Position.move(board, :right)

    assert new_board[:player_at] == %Coordinate{x: 2, y: 1}
  end
end
