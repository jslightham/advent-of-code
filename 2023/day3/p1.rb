# frozen_string_literal: true

arr = []
File.foreach('./2023/day3/data') do |line|
  arr << line.strip.split('').append('.')
end

def int?(str)
  str.to_i.to_s == str
end

def special_char?(char)
  char != '.' and !int?(char)
end

def adj_special_char?(arr, row_index, char_index)
  [[-1, 0], [1, 0], [0, -1], [0, 1], [1, 1], [-1, -1], [-1, 1], [1, -1]].each do |offset|
    next if (row_index + offset[0]).negative? || (char_index + offset[1]).negative? || (row_index + offset[0] >= arr.length) || (char_index + offset[1] >= arr[row_index].length)
    return true if special_char?(arr[row_index + offset[0]][char_index + offset[1]])
  end
  false
end

res = 0
arr.each_with_index do |row, row_index|
  current_number = 0
  found_special_char = false
  row.each_with_index do |el, col_index|
    if int? el
      current_number *= 10
      current_number += el.to_i
      found_special_char ||= adj_special_char?(arr, row_index, col_index)
    elsif found_special_char
      res += current_number
      current_number = 0
      found_special_char = false
    else
      current_number = 0
    end
  end
end

puts res
