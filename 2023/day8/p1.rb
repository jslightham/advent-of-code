# frozen_string_literal: true

f = File.open('./2023/day8/data')
directions = f.readline.strip.split('')

graph = {}
f.each_line do |line|
  line.strip!
  next if line.empty?

  graph[line.split(' ')[0]] = line.split('(')[1].split(')')[0].split(', ')
end

i = 0
res = 0
cur_pos = 'AAA'
while cur_pos != 'ZZZ'
  i = 0 if i == directions.length

  cur_pos = graph[cur_pos][0] if directions[i] == 'L'
  cur_pos = graph[cur_pos][1] if directions[i] == 'R'
  i += 1
  res += 1
end

puts res
