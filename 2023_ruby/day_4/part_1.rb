cards = IO.readlines("./input.txt").map do |line|
  values = line.sub!(/Card(\s)*\d+: /, "").strip.split("|")

  {winning_values: values[0].split(" ").collect(&:strip), card_values: values[1].split(" ").collect(&:strip)}
end

point_values = cards.map do |card|
  card[:winning_values].reduce(0) do |points, value|
    if card[:card_values].include?(value)
      (points > 0) ? points * 2 : 1
    else
      points
    end
  end
end

p point_values.sum
