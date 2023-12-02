res = 0
numbers = %w[one two three four five six seven eight nine]

File.foreach("./2023/day1/data") do |line|
  first_digit_index = 10000
  first_digit = 0
  last_digit_index = -1
  last_digit = 0

  (1..9).each do |int|
    next if (line.index int.to_s).nil?
    if (line.index int.to_s) < first_digit_index
      first_digit_index = line.index int.to_s
      first_digit = int
    end

    if (line.rindex int.to_s) > last_digit_index
      last_digit_index = line.rindex int.to_s
      last_digit = int
    end
  end

  numbers.each_with_index do |int, index|
    next if (line.rindex int).nil?
    if (line.index int) < first_digit_index
      first_digit_index = line.index int
      first_digit = index + 1
    end

    if (line.rindex int) > last_digit_index
      last_digit_index = line.rindex int
      last_digit = index + 1
    end
  end

  res += first_digit * 10 + last_digit
end

puts res
