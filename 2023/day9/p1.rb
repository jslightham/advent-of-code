# frozen_string_literal: true

inputs = []
File.foreach('./2023/day9/data') do |line|
  inputs << line.split(' ').map(&:to_i)
end

def add_derivative(inputs)
  return 0 if inputs.all?(&:zero?)
  inputs[-1] + add_derivative(inputs.map.with_index { |x, i| i.zero? ? x : x - inputs[i - 1] }[1..inputs.length])
end

puts inputs.map { |input| add_derivative input }.sum
