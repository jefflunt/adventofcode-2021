# 
def raw_rate(input, bit_width)
  input
    .reduce([0] * bit_width) do |acc, line|
      line
        .chars
        .each.with_index{|c, i| c == '1' ? acc[i] += 1 : nil }

      acc
    end.map do |count|
      count >= input.length / 2 ? 1 : 0
    end.join.to_i(2)
end

# Recursively filters `remaining_set' until either:
# - there is only a single number left in the list (returning that number), OR
# - the list cannot be filtered any further, and more than one number remains
#   (raising an error)
#
# Params:
# - selector_chars: array of bits used to select matching numbers from remaining_set
# - remaining_set: list of numbers to continuously filter
# - system: either :oxy (keep most common) or :co2 (keep least common)
# - i: the index of the selector to use for selection
def rating(selector_chars, remaining_set, i=0)
  return remaining_set.first if remaining_set.length == 1
  raise "not able to narrow list to single number" if i == selector_chars.length

  rating(
    selector_chars,
    remaining_set.select{|n| n[i] == selector_chars[i] },
    i+1,
  )
end

input = $stdin
  .read
  .lines
  .map{|l| l.strip }

bit_width = input.first.length

gamma = raw_rate(input, bit_width)

# epsilon is the bitwise XOR of gamma, but we must XOR it with something of the
# same bit width as the input numbers
epsilon = gamma ^ (['1'] * bit_width).join.to_i(2)
product = gamma * epsilon

puts "    gamma (bin/dec): #{gamma.to_s(2).rjust(bit_width, '0')} / #{gamma}"
puts "  epsilon (bin/dec): #{epsilon.to_s(2).rjust(bit_width, '0')} / #{epsilon}"
puts "      product (dec): #{product}"
puts '-' * 40

oxy = rating(gamma.to_s(2).rjust(bit_width, '0'), input).to_i(2)
co2 = rating(epsilon.to_s(2).rjust(bit_width, '0'), input).to_i(2)

puts "      oxygen rating (  gamma/bin/dec): #{gamma.to_s(2).rjust(bit_width, '0')} / #{oxy.to_s(2).rjust(bit_width, '0')} / #{oxy}"
puts "         co2 rating (epsilon/bin/dec): #{epsilon.to_s(2).rjust(bit_width, '0')} / #{co2.to_s(2).rjust(bit_width, '0')} / #{co2}"
puts "life support rating: #{oxy * co2}"
