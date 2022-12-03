defmodule Rucksack do
  def read_lines do
    File.read!(Path.expand("~/co/aoc-2022/03/input.txt"))
    |> String.split("\n", trim: true)
  end

  # Part 1

  def split_compartments(rucksack) do
    len = String.length(rucksack)
    String.split_at(rucksack, trunc(len / 2))
  end

  def find_duplicate_item(compartments) do
    {comp1, comp2} = compartments
    Enum.find(String.graphemes(comp1), fn x -> String.contains?(comp2, x) end)
  end

  def get_priority_for_item(item) do
    char = hd(String.to_charlist(item))

    cond do
      65 <= char and char <= 90 ->
        char - 65 + 26 + 1

      97 <= char and char <= 122 ->
        char - 97 + 1
    end
  end

  # Part 2

  def chunk_in_threes(lines) do
    Enum.chunk_every(lines, 3)
  end

  def find_badge(rucksacks) do
    Enum.find(String.graphemes(hd(rucksacks)), fn x ->
      Enum.all?(tl(rucksacks), fn r -> String.contains?(r, x) end)
    end)
  end
end

defmodule Solution do
  def solve_part1 do
    Rucksack.read_lines()
    |> Enum.map(&Rucksack.split_compartments/1)
    |> Enum.map(&Rucksack.find_duplicate_item/1)
    |> Enum.map(&Rucksack.get_priority_for_item/1)
    |> Enum.sum()
  end

  def solve_part2 do
    Rucksack.read_lines()
    |> Rucksack.chunk_in_threes()
    |> Enum.map(&Rucksack.find_badge/1)
    |> Enum.map(&Rucksack.get_priority_for_item/1)
    |> Enum.sum()
  end
end

# 1: 7793
IO.inspect(Solution.solve_part1())

# 1: 2499
IO.inspect(Solution.solve_part2())
