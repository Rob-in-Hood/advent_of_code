regex = /(?=[^\d])(?=[^\.])/

def includes_matches?(chars_array, regex)
  chars_array.any? { |char| char&.match?(regex) }
end

lines = IO.readlines("./adventofcode.com_2023_day_3_input.txt").map do |line|
  matches = line.enum_for(:scan, /\d+/).map { Regexp.last_match }

  digits_matches = matches.map do |match|
    substring = match[0]
    index = match.begin(0)
    {digit: substring, index: index}
  end

  {chars: line.strip.chars, digits_matches: digits_matches}
end

result = lines.each_with_index.map do |line, i|
  chars = line[:chars]
  previous_chars = lines[i - 1][:chars] if i > 0
  next_chars = lines[i + 1][:chars] if i < lines.length - 1

  digits = line[:digits_matches].map do |match|
    first_index = (match[:index] > 0) ? match[:index] - 1 : 0
    last_index = match[:index] + match[:digit].length
    last_index = chars.length if last_index > chars.length

    (chars[first_index]&.match?(regex) ||
      chars[last_index]&.match?(regex) ||
      (includes_matches?(previous_chars.values_at(first_index..last_index), regex) if previous_chars) ||
      (includes_matches?(next_chars.values_at(first_index..last_index), regex) if next_chars)) ?
      match[:digit].to_i : 0
  end

  digits.sum
end

p result.sum
