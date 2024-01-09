# frozen_string_literal: true

grid = []
start_pos = [0, 0]
File.foreach('./2023/day10/data').with_index do |line, number|
  start_pos = [line.index('S'), number] if line.include? 'S'
  grid << line.strip.split('')
end

# +x direction is right, +y direction is down

puts "Start POS: x: #{start_pos[0]} y: #{start_pos[1]}"
grid[start_pos[1]][start_pos[0]] = 'X'

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

while cur_pos != start_pos
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
    grid[cur_pos[1]][cur_pos[0]] = if grid[cur_pos[1]][cur_pos[0]] == 'L' || grid[cur_pos[1]][cur_pos[0]] == 'J' || grid[cur_pos[1]][cur_pos[0]] == '|'
                                     'X'
                                   else
                                     ' '
                                   end
    break
  end
  grid[last_pos[1]][last_pos[0]] = if grid[last_pos[1]][last_pos[0]] == 'L' || grid[last_pos[1]][last_pos[0]] == 'J' || grid[last_pos[1]][last_pos[0]] == '|'
                                     'X'
                                   else
                                     ' '
                                   end
end

area = 0
grid.reverse.each do |row|
  num_x = 0
  temp_count = 0
  row.each do |char|
    if char == 'X'
      num_x += 1
      area += temp_count
      temp_count = 0
      next
    end
    temp_count += 1 if num_x.odd? && char != ' '
  end
end

puts area
