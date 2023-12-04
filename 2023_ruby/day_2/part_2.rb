lines = IO.readlines("./adventofcode.com_2023_day_2_input.txt").map do |line|
  game, gameplay = line.split(":")
  game.sub!("Game ", "")
  subsets = gameplay.split(";").map { |subset| subset.split(",") }

  colors = {
    "red" => 0,
    "green" => 0,
    "blue" => 0
  }

  subsets.each do |subset|
    subset.each do |color|
      number, color = color.strip.split(" ")
      colors[color] = number.to_i if number.to_i > colors[color]
    end
  end

  colors.values.inject(:*)
end

p lines.sum
