res = 0

File.foreach("./2023/day2/data") do |line|
  game_arr = line.split(":")[1].split(";")
  max = {
    "red" => 0,
    "green" => 0,
    "blue" => 0
  }

  game_arr.each_with_index do |game|
    color_dat = game.split(",")
    color_dat.each do |el|
      inner_color_dat = el.split(" ")
      max[inner_color_dat[1].gsub(",", "")] = [max[inner_color_dat[1].gsub(",", "")], inner_color_dat[0].to_i].max
    end
  end

  inner_res = 1
  max.each do |el|
    inner_res *= el[1]
  end
  res += inner_res

end
puts res
