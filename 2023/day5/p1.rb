# frozen_string_literal: true

f = File.open('./2023/day5/data')
seeds = f.first.strip.split(': ')[1].split(' ').map(&:to_i)
updated_seeds = seeds.clone

f.each_line do |line|
  seeds = updated_seeds if line.include? 'map'
  next if line.include?('seed') || line.strip.empty? || line.include?('map')

  source_start = line.split(' ')[1].to_i
  dest_start = line.split(' ')[0].to_i
  range = line.split(' ')[2].to_i

  updated_seeds = seeds.each_with_index.map do |seed, i|
    if seed >= source_start && seed < source_start + range
      dest_start + (seed - source_start)
    else
      updated_seeds[i]
    end
  end
end

puts updated_seeds.min
