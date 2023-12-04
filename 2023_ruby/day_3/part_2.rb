regex = /\*/

def includes_matches?(chars_array, regex)
  chars_array.any? { |char| char&.match?(regex) }
end

def find_match(chars_array, regex)
  chars_array.index { |char| char&.match?(regex) }
end

def flatten(array)
  array.delete_if(&:empty?).flatten
end

def merge_hashes(array_of_hashes, key)
  array_of_hashes.sort { |a, b| a[key] <=> b[key] }
    .chunk { |h| h[key] }
    .each_with_object([]) { |h, result| result << h.last }
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

    if chars[first_index]&.match?(regex)
      {digit: match[:digit].to_i, gear: [i, first_index]}
    elsif chars[last_index]&.match?(regex)
      {digit: match[:digit].to_i, gear: [i, last_index]}
    else
      previous_array = previous_chars.values_at(first_index..last_index) if previous_chars
      next_array = next_chars.values_at(first_index..last_index) if next_chars

      if (includes_matches?(previous_array, regex) if previous_array)
        {digit: match[:digit].to_i, gear: [i - 1, first_index + find_match(previous_array, regex)]}
      elsif (includes_matches?(next_array, regex) if next_array)
        {digit: match[:digit].to_i, gear: [i + 1, first_index + find_match(next_array, regex)]}
      else
        {}
      end
    end
  end

  flatten(digits)
end

result = merge_hashes(flatten(result), :gear).map do |hashes|
  (hashes.length > 1) ? hashes[0][:digit] * hashes[1][:digit] : 0
end

p result.sum
