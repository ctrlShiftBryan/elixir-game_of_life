defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  alias GameOfLife.Board
  alias GameOfLife.Cell

  describe "Cell" do
    test "live_neighbor_count" do
      board =
        Board.parse("""
        101
        111
        011
        """)

      assert Cell.live_neighbor_count(board, {0, 0}) == 2
      assert Cell.live_neighbor_count(board, {1, 0}) == 5
      assert Cell.live_neighbor_count(board, {2, 0}) == 2

      assert Cell.live_neighbor_count(board, {0, 1}) == 3
      assert Cell.live_neighbor_count(board, {1, 1}) == 6
      assert Cell.live_neighbor_count(board, {2, 1}) == 4

      assert Cell.live_neighbor_count(board, {0, 2}) == 3
      assert Cell.live_neighbor_count(board, {1, 2}) == 4
      assert Cell.live_neighbor_count(board, {2, 2}) == 3
    end

    test "evolve - live cell with fewer than two live neighbours dies" do
      board =
        Board.parse("""
        000
        011
        000
        """)

      assert Cell.evolve(board, {1, 1}) == 0
    end
  end

  describe "Board" do
    test "parse 4x2" do
      str = """
      0000
      0110
      """

      assert %{
               {0, 0} => 0,
               {1, 0} => 0,
               {2, 0} => 0,
               {3, 0} => 0,
               {0, 1} => 0,
               {1, 1} => 1,
               {2, 1} => 1,
               {3, 1} => 0
             } == Board.parse(str)
    end

    test "parse" do
      str = """
      000
      011
      000
      """

      assert %{
               {0, 0} => 0,
               {1, 0} => 0,
               {2, 0} => 0,
               {0, 1} => 0,
               {1, 1} => 1,
               {2, 1} => 1,
               {0, 2} => 0,
               {1, 2} => 0,
               {2, 2} => 0
             } == Board.parse(str)
    end

    test "will return a board" do
      assert Board.new(3, 3) ==
               %{
                 {0, 0} => 0,
                 {1, 0} => 0,
                 {2, 0} => 0,
                 {0, 1} => 0,
                 {1, 1} => 0,
                 {2, 1} => 0,
                 {0, 2} => 0,
                 {1, 2} => 0,
                 {2, 2} => 0
               }
    end
  end

  test "any live cell with fewer than two live nieghboers dies" do
  end
end
