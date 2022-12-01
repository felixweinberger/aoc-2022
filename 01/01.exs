# File.stream!("./input.txt")
# |> Stream.map(&String.trim/1)
# |> Stream.with_index()
# |> Stream.map(fn {line, index} -> IO.puts("#{index + 1} #{line}") end)
# |> Stream.run()

{:ok, file} = File.read(Path.expand("~/co/aoc-2022/01/input.txt"))
lines = file |> String.split("\n") |> Enum.map(String.to_integer() / 1)
IO.puts(lines)
