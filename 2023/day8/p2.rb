# frozen_string_literal: true

f = File.open('./2023/day8/data')
directions = f.readline.strip.split('')

starting_vertices = []
graph = {}
f.each_line do |line|
  line.strip!
  next if line.empty?

  vertex_label = line.split(' ')[0]
  graph[vertex_label] = line.split('(')[1].split(')')[0].split(', ')
  starting_vertices << vertex_label if vertex_label.end_with? 'A'
end

res = -1
starting_vertices.each do |vertex|
  i = 0
  curr_length = 0
  cur_pos = vertex
  until cur_pos.end_with? 'Z'
    i = 0 if i == directions.length

    cur_pos = graph[cur_pos][0] if directions[i] == 'L'
    cur_pos = graph[cur_pos][1] if directions[i] == 'R'
    i += 1
    curr_length += 1
  end
  res = if res == -1
          curr_length
        else
          res.lcm(curr_length)
        end
end

puts res
