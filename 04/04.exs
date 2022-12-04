defmodule Cleanup do
  def read_lines do
    File.read!(Path.expand("~/co/aoc-2022/04/input.txt"))
    |> String.split("\n", trim: true)
  end

  def get_range_from_string(s) do
    String.split(s, "-", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  def get_ranges(s) do
    String.split(s, ",", trim: true)
    |> Enum.map(&Cleanup.get_range_from_string/1)
  end

  def get_max_width_range(ranges) do
    Enum.max_by(ranges, fn x -> elem(x, 1) - elem(x, 0) end)
  end

  def do_ranges_overlap_fully?(ranges) do
    max_width_range = Cleanup.get_max_width_range(ranges)

    Enum.all?(ranges, fn x ->
      elem(x, 1) <= elem(max_width_range, 1) && elem(max_width_range, 0) <= elem(x, 0)
    end)
  end

  def do_ranges_overlap?(ranges) do
    max_width_range = Cleanup.get_max_width_range(ranges)

    Enum.all?(ranges, fn x ->
      elem(x, 1) >= elem(max_width_range, 0) && elem(x, 0) <= elem(max_width_range, 1)
    end)
  end
end

defmodule Solution do
  def solve_part1 do
    Cleanup.read_lines()
    |> Enum.map(&Cleanup.get_ranges/1)
    |> Enum.map(&Cleanup.do_ranges_overlap_fully?/1)
    |> Enum.count(fn x -> x end)
  end

  def solve_part2 do
    Cleanup.read_lines()
    |> Enum.map(&Cleanup.get_ranges/1)
    |> Enum.map(&Cleanup.do_ranges_overlap?/1)
    |> Enum.count(fn x -> x end)
  end
end

# 1: 562
IO.inspect(Solution.solve_part1())

# 2: 924
IO.inspect(Solution.solve_part2())
