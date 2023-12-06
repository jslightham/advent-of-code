# frozen_string_literal: true

res = 1
f = File.open('./2023/day6/data')
times = f.readline.scan(/\d+/).map(&:to_i)
distances = f.readline.scan(/\d+/).map(&:to_i)

times.each_with_index do |time, i|
  res *= (0..time).reduce(0) { |acc, j| distances[i] < (time - j) * j ? acc + 1 : acc }
end

puts res
