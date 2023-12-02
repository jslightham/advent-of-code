res = 0
File.foreach("./2023/day1/data") do |line|
  first_int = -1
  last_int = -1
  line.each_byte do |b|
    first_int = b - 48 if first_int == -1  and b > 47 and b < 58
    last_int = b - 48 if b > 47 and b < 58
  end
  res += first_int * 10 + last_int
end
puts res
