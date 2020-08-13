defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  setup do
    board = %{
      :player_at => %Coordinate{x: 1, y: 1},
      %Coordinate{x: 0, y: 0} => %Cell{occupied_by: nil, type: :corridor},
      %Coordinate{x: 0, y: 1} => %Cell{occupied_by: nil, type: :corridor},
      %Coordinate{x: 0, y: 2} => %Cell{occupied_by: nil, type: :corridor},
      %Coordinate{x: 1, y: 0} => %Cell{occupied_by: nil, type: :corridor},
      %Coordinate{x: 1, y: 1} => %Cell{occupied_by: :player, type: :corridor},
      %Coordinate{x: 1, y: 2} => %Cell{occupied_by: nil, type: :corridor},
      %Coordinate{x: 2, y: 0} => %Cell{occupied_by: nil, type: :corridor},
      %Coordinate{x: 2, y: 1} => %Cell{occupied_by: nil, type: :corridor},
      %Coordinate{x: 2, y: 2} => %Cell{occupied_by: nil, type: :corridor}
    }

    [board: board]
  end

  describe "moving left" do
    test "it will move the player one cell to the left", context do
      board = context[:board]
      board = Position.move(board, :left)

      assert board[%Coordinate{x: 0, y: 1}] == %Cell{type: :corridor, occupied_by: :player}
      assert board[%Coordinate{x: 1, y: 1}] == %Cell{type: :corridor, occupied_by: :nil}
    end
  end

  describe "moving up" do
    test "it will move the player one cell up", context do
      board = context[:board]
      board = Position.move(board, :up)

      assert board[%Coordinate{x: 1, y: 0}] == %Cell{type: :corridor, occupied_by: :player}
      assert board[%Coordinate{x: 1, y: 1}] == %Cell{type: :corridor, occupied_by: :nil}
    end
  end

  describe "moving down" do
    test "it will move the player one cell down", context do
      board = context[:board]
      board = Position.move(board, :down)

      assert board[%Coordinate{x: 1, y: 2}] == %Cell{type: :corridor, occupied_by: :player}
      assert board[%Coordinate{x: 1, y: 1}] == %Cell{type: :corridor, occupied_by: :nil}
    end
  end

  describe "moving right" do
    test "it will move the player one cell to the right", context do
      board = context[:board]
      board = Position.move(board, :right)

      assert board[%Coordinate{x: 2, y: 1}] == %Cell{type: :corridor, occupied_by: :player}
      assert board[%Coordinate{x: 1, y: 1}] == %Cell{type: :corridor, occupied_by: :nil}
    end
  end

  test "it will update the player coordinate", context do
    board = context[:board]
    board = Position.move(board, :right)

    assert board[:player_at] == %Coordinate{x: 2, y: 1}
  end
end
