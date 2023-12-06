cards = IO.readlines("./input.txt").map do |line|
  values = line.sub!(/Card(\s)*\d+: /, "").strip.split("|")

  [{winning_values: values[0].split(" ").collect(&:strip), card_values: values[1].split(" ").collect(&:strip)}]
end

cards.each_with_index do |card, i|
  values = card[0][:winning_values] & card[0][:card_values]

  values.length.times do |next_card|
    card.length.times do |times|
      cards[i + next_card + 1] << cards[i + next_card + 1][0] if cards.length > (i + next_card + 1)
    end
  end
end

p cards.flatten.length
