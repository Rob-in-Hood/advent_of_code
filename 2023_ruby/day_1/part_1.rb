lines = IO.readlines("./adventofcode.com_2023_day_1_input.txt").map do |line|
  result = line.scan(/\d/)
  (result.first + result.last).to_i
end

p lines.sum
