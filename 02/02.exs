defmodule RockPaperScissors do
  def score_round(round_string) do
    scoring = %{
      "X" => %{"points" => 1, "win" => "C", "draw" => "A"},
      "Y" => %{"points" => 2, "win" => "A", "draw" => "B"},
      "Z" => %{"points" => 3, "win" => "B", "draw" => "C"}
    }

    me = String.at(round_string, 2)
    them = String.at(round_string, 0)

    cond do
      them == scoring[me]["win"] ->
        scoring[me]["points"] + 6

      them == scoring[me]["draw"] ->
        scoring[me]["points"] + 3

      true ->
        scoring[me]["points"]
    end
  end

  def play_round(round_string) do
    response = %{
      "X" => %{"A" => "Z", "B" => "X", "C" => "Y"},
      "Y" => %{"A" => "X", "B" => "Y", "C" => "Z"},
      "Z" => %{"A" => "Y", "B" => "Z", "C" => "X"}
    }

    them = String.at(round_string, 0)
    me = response[String.at(round_string, 2)][them]

    score_round(them <> " " <> me)
  end
end

rounds =
  File.read!(Path.expand("~/co/aoc-2022/02/input.txt"))
  |> String.split("\n", trim: true)

# 1: 12794
ans1 =
  rounds
  |> Enum.map(&RockPaperScissors.score_round/1) |> Enum.sum()
IO.inspect(ans1)

# 2: 14979
ans2 =
  rounds
  |> Enum.map(&RockPaperScissors.play_round/1) |> Enum.sum()
IO.inspect(ans2)
