DIGITS_MAP = {
  "1" => "1",
  "2" => "2",
  "3" => "3",
  "4" => "4",
  "5" => "5",
  "6" => "6",
  "7" => "7",
  "8" => "8",
  "9" => "9",
  "one" => "1",
  "two" => "2",
  "three" => "3",
  "four" => "4",
  "five" => "5",
  "six" => "6",
  "seven" => "7",
  "eight" => "8",
  "nine" => "9"
}

regex = /#{DIGITS_MAP.keys.join("|")}/

reverse_regex = /#{DIGITS_MAP.keys.map(&:reverse).join("|")}/

lines = IO.readlines("./adventofcode.com_2023_day_1_input.txt").map do |line|
  result = line.scan(regex)
  r_result = line.reverse.scan(reverse_regex)
  (DIGITS_MAP[result.first] + DIGITS_MAP[r_result.first.reverse]).to_i
end

p lines.sum
