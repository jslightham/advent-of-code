# frozen_string_literal: true

card_win_map = []
total_cards = 0
File.foreach('./2023/day4/data') do |line|
  total_cards += 1
  winning_nums = line.split(':')[1].strip.split(' | ')[0].split(' ').map(&:itself)
  your_nums = line.split(':')[1].strip.split(' | ')[1].split(' ').map(&:itself)
  card_win_map[total_cards - 1] = your_nums.count { |num| winning_nums.include?(num) }
end

cards_to_process = Array.new(card_win_map.length) { |i| i }
until cards_to_process.empty?
  current_card = cards_to_process.pop
  card_win_map[current_card].times do |i|
    cards_to_process << i + current_card + 1
    total_cards += 1
  end
end

puts total_cards
