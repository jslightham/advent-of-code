# frozen_string_literal: true

res = 0
File.foreach('./2023/day4/data') do |line|
  winning_nums = line.split(':')[1].strip.split(' | ')[0].split(' ').map(&:to_i)
  your_nums = line.split(':')[1].strip.split(' | ')[1].split(' ').map(&:to_i)
  num_matches = your_nums.count { |num| winning_nums.include?(num) }
  res += 2**(num_matches - 1) if num_matches.positive?
end
puts res
