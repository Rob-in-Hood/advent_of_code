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
end

file_text = IO.read("input.txt")

chunks = file_text.scan(/(([a-z]|-|\s)+:(\d|\s|\n|,)+)/)

maps_array = chunks.map do |chunk|
  name, value = chunk[0].split(":")
  {name => value.strip.split("\n").map { |line| line.split(" ").map(&:to_i) }.sort_by(&:second).reverse}
end

maps = maps_array.reduce({}, :merge)

seeds = maps["seeds"].flatten

locations = seeds.map do |seed|
  current = seed

  MAPS_NAMES.each_with_index do |name, i|
    correspondence = maps[name].find { |range| (range[1] <= current) && (range[1] + range[2] - 1 >= current) }

    if (i < MAPS_NAMES.length) && correspondence
      difference = current - correspondence[1]
      current = correspondence[0] + difference
    end
  end

  current
end

p locations.min
