# frozen_string_literal: true

arr = []
gear_map = {}

File.foreach('./2023/day3/data') do |line|
  arr << line.strip.split('').append('.')
end

def int?(str)
  str.to_i.to_s == str
end

def has_gear?(arr, row_index, char_index)
  [[-1, 0], [1, 0], [0, -1], [0, 1], [1, 1], [-1, -1], [-1, 1], [1, -1]].each do |offset|
    if (row_index + offset[0]).negative? || (char_index + offset[1]).negative? || (row_index + offset[0] >= arr.length) || (char_index + offset[1] >= arr[row_index].length)
      next
    end
    return [row_index + offset[0], char_index + offset[1]] if arr[row_index + offset[0]][char_index + offset[1]] == '*'
  end
  nil
end

res = 0
arr.each_with_index do |row, row_index|
  current_number = 0
  connected_gears = []
  row.each_with_index do |el, col_index|
    if el.to_i.to_s == el
      current_number *= 10
      current_number += el.to_i
      g = has_gear?(arr, row_index, col_index)
      connected_gears << g unless g.nil?
    elsif connected_gears.length.positive?
      connected_gears.each do |gear|
        gear_map[gear.to_s] = [] if gear_map[gear.to_s].nil?
        gear_map[gear.to_s] << current_number unless gear_map[gear.to_s].include?(current_number)
      end
      current_number = 0
      connected_gears = []
    else
      current_number = 0
    end
  end
end

gear_map.each_value do |value|
  res += value[0] * value[1] if value.length == 2
end

puts res
