defmodule GameOfLife do
  defmodule Cell do
    @spec live_neighbor_count(map(), {number(), number()}) :: number()
    def live_neighbor_count(board, {x, y} = _position) do
      neighbors =
        for x_offset <- -1..1, y_offset <- -1..1 do
          if x_offset == 0 && y_offset == 0 do
            0
          else
            board[{x + x_offset, y + y_offset}]
          end
        end

      neighbors
      |> Enum.filter(&(&1 != nil))
      |> Enum.sum()
    end

    @spec evolve(map(), {number(), number()}) :: 0 | 1
    def evolve(board, {x, y} = position) do
      neighbors = live_neighbor_count(board, position)
      current_state = board[{x, y}]

      cond do
        neighbors < 2 -> 0
        neighbors == 2 || neighbors == 3 -> 1
        neighbors > 3 -> 0
        current_state == 0 && neighbors == 3 -> 1
      end
    end
  end

  defmodule Board do
    @spec new(integer(), integer()) :: map()
    def new(width, length) do
      for x <- 0..(width - 1), y <- 0..(length - 1), into: %{}, do: {{x, y}, 0}
    end

    @spec parse(binary()) :: map()
    def parse(string) do
      only_string = String.replace(string, ~r/[^01]/, "")
      height = string |> String.split("\n") |> Enum.count() |> Kernel.-(1)
      width = string |> String.split("\n") |> Enum.at(0) |> String.length()

      for y <- 0..(height - 1), x <- 0..(width - 1) do
        target_space = String.at(only_string, y * width + x)
        %{{x, y} => (target_space == "1" && 1) || 0}
      end
      |> Enum.reduce(fn x, acc -> Map.merge(x, acc) end)
    end
  end
end
