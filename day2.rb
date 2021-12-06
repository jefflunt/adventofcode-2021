# Parses a command like:
#   foward 2
#   down 5
#   up 3
#
# ... and returns a 2-element array of [horiz_delta, depth_delta]
def parse_cmd(cmd)
  cmd
    .strip
    .split
    .each_cons(2)
    .map do |dir, amt|
      case dir
      when 'forward'  then [amt.to_i, 0]
      when 'up'       then [0, -amt.to_i]
      when 'down'     then [0, amt.to_i]
      else
        raise "unknown cmd: `#{cmd}', split into (#{dir}, #{amt})"
      end
    end.flatten
end

horiz = 0
depth = 0

$stdin
  .read
  .lines
  .map{|l| parse_cmd(l) }
  .each.with_index{|(h, d), i| horiz += h; depth += d; puts "#{i.to_s.rjust(5)}: h: #{horiz}, d: #{depth}" }
