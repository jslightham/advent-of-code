# frozen_string_literal: true

# This is actually identical to p1, except for the offset of + 1_000_000 which was previously + 2

def build_space_arr(grid)
  offset = []
  grid.each_with_index do |row, i|
    offset << if row.include? '#'
                if offset.empty?
                  0
                else
                  offset[i - 1] + 1
                end
              elsif offset.empty?
                1
              else
                offset[i - 1] + 1_000_000
              end
  end
  offset
end

res = 0
grid = []
File.foreach('./2023/day11/data') do |line|
  grid << line.strip.split('')
end

row_offset = build_space_arr grid
col_offset = build_space_arr grid.transpose

found_galaxies = []
grid.each_with_index do |row, r|
  row.each_with_index do |char, c|
    next unless char == '#'

    found_galaxies.each do |galaxy|
      res += (row_offset[r] - galaxy[:x]).abs + (col_offset[c] - galaxy[:y]).abs
    end

    found_galaxies << {
      x: row_offset[r],
      y: col_offset[c]
    }
  end
end

puts res
