defmodule Tuning do
  def read_signal do
    File.read!(Path.expand("~/co/aoc-2022/06/input.txt"))
    |> String.split("\n", trim: true)
    |> hd
  end

  def has_all_different_characters?(substring) do
    substring
    |> String.graphemes()
    |> Enum.frequencies()
    |> Enum.all?(fn {_k, v} -> v <= 1 end)
  end

  def create_substrings(signal, size) do
    Enum.map(0..String.length(signal)-size+1, fn i ->
      String.slice(signal, i, size)
    end)
  end

  def find_first_marker(substrings) do
    Enum.find_index(substrings, fn x -> Tuning.has_all_different_characters?(x) end)
  end
end

defmodule Solution do
  def solve_part1 do
    idx = Tuning.read_signal()
    |> Tuning.create_substrings(4)
    |> Tuning.find_first_marker()
    idx + 4
  end

  def solve_part2 do
    idx = Tuning.read_signal()
    |> Tuning.create_substrings(14)
    |> Tuning.find_first_marker()
    idx + 14
  end
end

# 1: 1929
IO.inspect(Solution.solve_part1())

# 2: 3298
IO.inspect(Solution.solve_part2())
