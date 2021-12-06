puts $stdin
  .read
  .lines
  .map{|l| l.to_i}
  .each_cons(3)
  .map{|a, b, c| a + b + c }
  .each_cons(2)
  .map{|before, after| after - before }
  .count{|diff| diff > 0 }
