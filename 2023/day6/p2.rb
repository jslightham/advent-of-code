# frozen_string_literal: true

f = File.open('./2023/day6/data')
time = f.readline.split(':')[1].gsub(' ', '').to_i
distance = f.readline.split(':')[1].gsub(' ', '').to_i
puts (0..time).reduce(0) { |acc, j| distance < (time - j) * j ? acc + 1 : acc }
