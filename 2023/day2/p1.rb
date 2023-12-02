MAX_COLOURS = {
  "red" => 12,
  "green" => 13,
  "blue" => 14
}

res = 0
File.foreach("./2023/day2/data") do |line|
  data = line.split(" ")
  game_num = data[1][0..data[1].length-2].to_i
  full_game_arr = line.split(":")[1].split(";")

  is_valid_game = true
  full_game_arr.each do |game|
    count = {
      "red" => 0,
      "green" => 0,
      "blue" => 0
    }

    game_round_arr = game.split(",")
    game_round_arr.each do |el|
      inner_color_dat = el.split(" ")
      count[inner_color_dat[1].gsub(",", "")] += inner_color_dat[0].to_i
    end
    if count["red"] > MAX_COLOURS["red"] or count["green"] > MAX_COLOURS["green"] or count["blue"] > MAX_COLOURS["blue"]
      is_valid_game = false
    end
  end
  if is_valid_game
    res += game_num
  end
end
puts res
