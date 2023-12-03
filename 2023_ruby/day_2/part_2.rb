p IO.readlines("./adventofcode.com_2023_day_2_input.txt").map {
  |line|
    game, gameplay = line.split(":")
    game.sub!("Game ", "")
    subsets = gameplay.split(";").map {|subset| subset.split(",")}

    colors = {
      "red" => 0,
      "green" => 0,
      "blue" => 0,
    }

    subsets.each {|subset| subset.each {
      |color|
        number, color = color.strip.split(" ")
        colors[color] = number.to_i if number.to_i > colors[color]
    }}

    colors.values.inject(:*)
}.sum
