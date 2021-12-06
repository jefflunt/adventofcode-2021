input = $stdin
  .read
  .lines
  .map{|l| l.strip }

bit_width = input.first.length

gamma = input
  .reduce([0] * bit_width) do |acc, line|
    line
      .chars
      .each.with_index{|c, i| c == '1' ? acc[i] += 1 : nil }

    acc
  end.map do |count|
    count >= input.length / 2 ? 1 : 0
  end.join.to_i(2)

# epsilon is the bitwise XOR of gamma, but we must XOR it with something of the
# same bit width as the input numbers
epsilon = gamma ^ (['1'] * bit_width).join.to_i(2)
product = gamma * epsilon

puts "  gamma (bin/dec): #{gamma.to_s(2).rjust(bit_width, '0')} / #{gamma}"
puts "epsilon (bin/dec): #{epsilon.to_s(2).rjust(bit_width, '0')} / #{epsilon}"
puts "    product (dec): #{product}"
