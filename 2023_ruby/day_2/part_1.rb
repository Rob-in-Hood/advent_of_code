CUBES = {
  "red" => 12,
  "green" => 13,
  "blue" => 14,
}

p IO.readlines("./adventofcode.com_2023_day_2_input.txt").map {
  |line|
    game, gameplay = line.split(":")
    game.sub!("Game ", "")
    subsets = gameplay.split(";").map {|subset| subset.split(",")}
    subsets.all? {|subset| subset.all? {
      |color|
        number, color = color.strip.split(" ")
        CUBES[color] >= number.to_i
    }} ? game.to_i : 0
}.sum
