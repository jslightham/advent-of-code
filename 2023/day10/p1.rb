# frozen_string_literal: true

grid = []
start_pos = [0, 0]
File.foreach('./2023/day10/data').with_index do |line, number|
  start_pos = [line.index('S'), number] if line.include? 'S'
  grid << line.split('')
end

# +x direction is right, +y direction is down

puts "Start POS: x: #{start_pos[0]} y: #{start_pos[1]}"

last_pos = start_pos
if (grid[start_pos[1] + 1][start_pos[0]] == '|') || (grid[start_pos[1] + 1][start_pos[0]] == 'J') || (grid[start_pos[1] + 1][start_pos[0]] == 'L')
  cur_pos = [start_pos[0], start_pos[1] + 1]
elsif (grid[start_pos[1]][start_pos[0] + 1] == '-') || (grid[start_pos[1]][start_pos[0] + 1] == 'J')
  cur_pos = [start_pos[0] + 1, start_pos[1]]
elsif (grid[start_pos[1]][start_pos[0] - 1] == '-') || (grid[start_pos[1]][start_pos[0] - 1] == 'L')
  cur_pos = [start_pos[0] - 1, start_pos[1]]
elsif (grid[start_pos[1] - 1][start_pos[0]] == '|') || (grid[start_pos[1] - 1][start_pos[0]] == 'F') || (grid[start_pos[1] - 1][start_pos[0]] == '7')
  cur_pos = [start_pos[0], start_pos[1] - 1]
end

dist = 0
log_count = 0

while cur_pos != start_pos
  dist += 1
  log_count += 1
  puts dist if (log_count % 100_000).zero?
  if (last_pos != [cur_pos[0],
                   cur_pos[1] + 1]) && (grid[cur_pos[1]][cur_pos[0]] == '|' || grid[cur_pos[1]][cur_pos[0]] == 'F' || grid[cur_pos[1]][cur_pos[0]] == '7') && ((grid[cur_pos[1] + 1][cur_pos[0]] == '|') || (grid[cur_pos[1] + 1][cur_pos[0]] == 'J') || (grid[cur_pos[1] + 1][cur_pos[0]] == 'L'))
    last_pos = [cur_pos[0], cur_pos[1]]
    cur_pos = [cur_pos[0], cur_pos[1] + 1]
  elsif (last_pos != [cur_pos[0] + 1,
                      cur_pos[1]]) && (grid[cur_pos[1]][cur_pos[0]] == 'L' || grid[cur_pos[1]][cur_pos[0]] == '-' || grid[cur_pos[1]][cur_pos[0]] == 'F') && ((grid[cur_pos[1]][cur_pos[0] + 1] == '-') || (grid[cur_pos[1]][cur_pos[0] + 1] == 'J') || (grid[cur_pos[1]][cur_pos[0] + 1] == '7'))
    last_pos = [cur_pos[0], cur_pos[1]]
    cur_pos = [cur_pos[0] + 1, cur_pos[1]]
  elsif (last_pos != [cur_pos[0] - 1,
                      cur_pos[1]]) && (grid[cur_pos[1]][cur_pos[0]] == '-' || grid[cur_pos[1]][cur_pos[0]] == '7' || grid[cur_pos[1]][cur_pos[0]] == 'J') && ((grid[cur_pos[1]][cur_pos[0] - 1] == '-') || (grid[cur_pos[1]][cur_pos[0] - 1] == 'L') || (grid[cur_pos[1]][cur_pos[0] - 1] == 'F'))
    last_pos = [cur_pos[0], cur_pos[1]]
    cur_pos = [cur_pos[0] - 1, cur_pos[1]]
  elsif (last_pos != [cur_pos[0],
                      cur_pos[1] - 1]) && (grid[cur_pos[1]][cur_pos[0]] == 'J' || grid[cur_pos[1]][cur_pos[0]] == 'L' || grid[cur_pos[1]][cur_pos[0]] == '|') && ((grid[cur_pos[1] - 1][cur_pos[0]] == '|') || (grid[cur_pos[1] - 1][cur_pos[0]] == 'F') || (grid[cur_pos[1] - 1][cur_pos[0]] == '7'))
    last_pos = [cur_pos[0], cur_pos[1]]
    cur_pos = [cur_pos[0], cur_pos[1] - 1]
  else
    break
  end
end

puts (dist / 2.0).ceil
