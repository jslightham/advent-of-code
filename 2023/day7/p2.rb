class PokerHand
  include Comparable

  attr_reader :hand, :bet, :type

  def initialize(hand, bet)
    @hand = hand.gsub('A', 'Z').gsub('K', 'Y').gsub('Q', 'X').gsub('J', '0').gsub('T', 'V')
    @bet = bet
    @type = get_hand_type hand.gsub('J', '')
  end

  def get_hand_type hand
    num_unique_cards = hand.chars.uniq.length
    num_jokers = 5 - hand.length
    unique_map = hand.chars.group_by(&:itself).map { |_char, instances| instances.length }
    return 1 if num_unique_cards == 1 || num_jokers == 5
    return 2 if (num_unique_cards == 2) && unique_map.include?(4 - num_jokers)
    return 3 if num_unique_cards == 2
    return 4 if (num_unique_cards == 3) && unique_map.include?(3 - num_jokers)
    return 5 if num_unique_cards == 3
    return 6 if num_unique_cards == 4

    7
  end

  def <=>(other)
    if @type == other.type
      @hand <=> other.hand
    else
      other.type <=> @type
    end
  end
end

hands = File.foreach('./2023/day7/data').map { |line| PokerHand.new(line.split(' ')[0], line.split(' ')[1].to_i) }

hands.sort!
ret = 0
hands.each_with_index do |hand, i|
  ret += hand.bet * (i + 1)
end
puts ret
