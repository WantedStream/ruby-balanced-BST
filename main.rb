require_relative "balancedbst"

t=Tree.new([4,5,6,1,2,3,4,56,5,8,11,22,22])
t.pretty_print

proc = Proc.new {|v| t.remove v.data}
proc.to_proc


t.pretty_print
puts t.height
puts t.depth(Node.new(1))