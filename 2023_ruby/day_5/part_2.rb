MAPS_NAMES = [
  "seed-to-soil map",
  "soil-to-fertilizer map",
  "fertilizer-to-water map",
  "water-to-light map",
  "light-to-temperature map",
  "temperature-to-humidity map",
  "humidity-to-location map"
]

class Array
  def second
    (length <= 1) ? nil : self[1]
  end

  def deep_dup
    map { |x| x.deep_dup }
  end
end

class Numeric
  def deep_dup
    self
  end
end

file_text = IO.read("input.txt")

chunks = file_text.scan(/(([a-z]|-|\s)+:(\d|\s|\n|,)+)/)

maps_array = chunks.map do |chunk|
  name, value = chunk[0].split(":")
  {name => value.strip.split("\n").map { |line| line.split(" ").map(&:to_i) }.sort_by(&:second).reverse}
end

maps = maps_array.reduce({}, :merge)

seeds = maps["seeds"].flatten
seeds = seeds.each_slice(2).to_a
seeds.map! { |seed| seed.insert(1, 0) }

locations = seeds.map do |seed|
  current_ranges = [seed]

  MAPS_NAMES.each_with_index do |name, i|
    new_ranges = current_ranges.map do |current_range|
      min = current_range[0]
      max = current_range[0] + current_range[2] - 1

      # ranges for min number
      correspondences = maps[name].deep_dup.select do |range|
        (range[1] + range[2] - 1 >= min) || (range[1] <= min && range[1] + range[2] - 1 >= min)
      end
      # ranges max number
      correspondences = correspondences.select do |range|
        (range[1] <= max) || (range[1] + range[2] - 1 >= max && range[1] <= max)
      end

      max_in_range = (correspondences.first[1] + correspondences.first[2] - 1 if correspondences.first)

      # create range if it doesn't exist
      if !max_in_range
        correspondences << [min, min, max - min + 1]
        max_in_range = max
      end

      # fill by only valuable values for max
      if max_in_range < max
        correspondences.unshift([max_in_range + 1, max_in_range + 1, max - max_in_range])
      elsif max_in_range > max
        difference = max_in_range - max
        correspondences.first[2] = correspondences.first[2] - difference
      end

      # fill by only valuable values for min
      if correspondences.last[1] > min
        correspondences << [min, min, correspondences.last[1] - min]
      elsif correspondences.last[1] < min
        difference = min - correspondences.last[1]
        correspondences.last[0] += difference
        correspondences.last[1] += difference
        correspondences.last[2] -= difference
      end

      correspondences
    end

    current_ranges = new_ranges.flatten(1)
  end

  current_ranges.map(&:first).min
end

p locations.min
