defmodule Crates do
  #                         [R] [J] [W]
  #             [R] [N]     [T] [T] [C]
  # [R]         [P] [G]     [J] [P] [T]
  # [Q]     [C] [M] [V]     [F] [F] [H]
  # [G] [P] [M] [S] [Z]     [Z] [C] [Q]
  # [P] [C] [P] [Q] [J] [J] [P] [H] [Z]
  # [C] [T] [H] [T] [H] [P] [G] [L] [V]
  # [F] [W] [B] [L] [P] [D] [L] [N] [G]
  #  1   2   3   4   5   6   7   8   9
  def get_starting_crates do
    %{
      1 => ['R', 'Q', 'G', 'P', 'C', 'F'],
      2 => ['P', 'C', 'T', 'W'],
      3 => ['C', 'M', 'P', 'H', 'B'],
      4 => ['R', 'P', 'M', 'S', 'Q', 'T', 'L'],
      5 => ['N', 'G', 'V', 'Z', 'J', 'H', 'P'],
      6 => ['J', 'P', 'D'],
      7 => ['R', 'T', 'J', 'F', 'Z', 'P', 'G', 'L'],
      8 => ['J', 'T', 'P', 'F', 'C', 'H', 'L', 'N'],
      9 => ['W', 'C', 'T', 'H', 'Q', 'Z', 'V', 'G']
    }
  end

  def read_lines do
    File.read!(Path.expand("~/co/aoc-2022/05/input.txt"))
    |> String.split("\n", trim: true)
  end

  def get_steps do
    Crates.read_lines()
    |> Enum.map(&Crates.parse_steps_from_line/1)
  end

  def parse_steps_from_line(line) do
    steps = String.split(line, " ") |> List.to_tuple()

    %{
      "count" => String.to_integer(elem(steps, 1)),
      "from" => String.to_integer(elem(steps, 3)),
      "to" => String.to_integer(elem(steps, 5))
    }
  end

  def apply_step(crates, step) do
    from = step["from"]
    to = step["to"]
    count = step["count"]

    Enum.reduce(0..(count - 1), crates, fn _x, acc ->
      new = Map.put(acc, to, [hd(acc[from]) | acc[to]])
      Map.put(new, from, tl(acc[from]))
    end)
  end

  def apply_steps(crates, steps) do
    Enum.reduce(steps, crates, fn step, acc ->
      Crates.apply_step(acc, step)
    end)
  end

  def apply_step_with_better_crane(crates, step) do
    from = step["from"]
    to = step["to"]
    count = step["count"]

    {moved, remaining} = Enum.split(crates[from], count)

    new = Map.put(crates, to, moved ++ crates[to])
    Map.put(new, from, remaining)
  end

  def apply_steps_with_better_crane(crates, steps) do
    Enum.reduce(steps, crates, fn step, acc ->
      Crates.apply_step_with_better_crane(acc, step)
    end)
  end

  def apply_steps_with_better_crane(crates, steps) do
    Enum.reduce(steps, crates, fn step, acc ->
      Crates.apply_step(acc, step)
    end)
  end

  def get_top_crates(crates) do
    Enum.map(crates, fn kv ->
      {_k, v} = kv
      hd(v)
    end)
  end
end

defmodule Solution do
  def solve_part1 do
    crates = Crates.get_starting_crates()
    steps = Crates.get_steps()
    final = Crates.apply_steps(crates, steps)
    Crates.get_top_crates(final) |> Enum.join("")
  end

  def solve_part2 do
    crates = Crates.get_starting_crates()
    steps = Crates.get_steps()
    final = Crates.apply_steps_with_better_crane(crates, steps)
    Crates.get_top_crates(final) |> Enum.join("")
  end
end

# 1: DHBJQJCCW
IO.inspect(Solution.solve_part1())

# 2: WJVRLSJJT
IO.inspect(Solution.solve_part2())
