gnomes =
  File.read!(Path.expand("~/co/aoc-2022/01/input.txt"))
  |> String.split("\n\n")
  |> Enum.map(fn x -> String.split(x, "\n", trim: true) |> Enum.map(&String.to_integer/1) end)
  |> Enum.map(&Enum.sum/1)
  |> Enum.sort
  |> Enum.reverse

# 70698
IO.inspect(Enum.max(gnomes))

# 206643
IO.inspect(Enum.sum(Enum.take(gnomes, 3)))
