CUBES = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

lines = IO.readlines("./adventofcode.com_2023_day_2_input.txt").map do |line|
  game, gameplay = line.split(":")
  game.sub!("Game ", "")
  subsets = gameplay.split(";").map { |subset| subset.split(",") }
  (subsets.all? do |subset|
    subset.all? do |color|
      number, color = color.strip.split(" ")
      CUBES[color] >= number.to_i
    end
  end) ? game.to_i : 0
end

p lines.sum
