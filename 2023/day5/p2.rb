# frozen_string_literal: true

# @brief Maps a range from one range to another
def map_range(source, map_to_range)
  offset = source.first - map_to_range[:source_range].first
  range = source.last - source.first
  (map_to_range[:dest_range].first + offset)..(map_to_range[:dest_range].first + offset + range)
end

# @brief Augments a list of ranges to include all values between the first and last range
def augment_ranges(ranges, min_val, max_val)
  augmented_ranges = []
  ranges.sort_by! { |range| range[:source_range].first }

  # Add the first range if it doesn't start at min_val
  if ranges[0][:source_range].first > min_val
    augmented_ranges << {
      source_range: (min_val..(ranges[0][:source_range].first - 1)),
      dest_range: (min_val..(ranges[0][:source_range].first - 1))
    }
  end

  # Add all ranges between the ranges that are in the list and the ones already in the list
  ranges.each do |range|
    # Add the range that goes from the previous to the current range
    if !augmented_ranges.empty? && (range[:source_range].first > augmented_ranges[-1][:source_range].last + 1)
      augmented_ranges << {
        source_range: ((augmented_ranges[-1][:source_range].last + 1)..(range[:source_range].first - 1)),
        dest_range: ((augmented_ranges[-1][:source_range].last + 1)..(range[:source_range].first - 1))
      }
    end
    augmented_ranges << range
  end

  # Add the last range if it doesn't end at max_val
  if ranges[-1][:source_range].last < max_val
    augmented_ranges << {
      source_range: ((ranges[-1][:source_range].last + 1)..max_val),
      dest_range: ((ranges[-1][:source_range].last + 1)..max_val)
    }
  end
  augmented_ranges
end

# Start of main program
f = File.open('./2023/day5/data')
seeds_in = f.first.strip.split(': ')[1].split(' ').map(&:to_i)
seeds = []

# Convert the seeds into ranges
i = seeds_in.length - 1
while i.positive?
  seeds << (seeds_in[i - 1]..(seeds_in[i - 1] + seeds_in[i]))
  i -= 2
end
seeds.sort_by!(&:first)

ranges = []
f.each_line do |line|
  next if line.include?('seed') || line.strip.empty?

  # Map indicates end of previous given mapping, map all seeds to new ranges
  if line.include?('map') || f.eof?
    puts line
    new_seeds = []
    seeds.each do |seed_range|
      last_pos = seed_range.first
      ranges = augment_ranges ranges, seeds[0].first, seeds[-1].last
      ranges.each do |range|
        next if seed_range.first > range[:source_range].last || seed_range.last < range[:source_range].first

        pos = [seed_range.last, range[:source_range].last].min
        new_seeds << map_range((last_pos..pos), range)
        puts "Mapped #{last_pos..pos} to #{map_range((last_pos..pos), range)}"
        last_pos = pos + 1
      end
    end
    ranges = []
    seeds = new_seeds
    next
  end

  source_start = line.split(' ')[1].to_i
  dest_start = line.split(' ')[0].to_i
  range = line.split(' ')[2].to_i
  ranges << {
    source_range: (source_start..(source_start + range - 1)),
    dest_range: (dest_start..(dest_start + range - 1))
  }
end

seeds.sort_by!(&:first)
puts seeds[0].first
