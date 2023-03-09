require_relative "balancedbst"

t=Tree.new([4,5,6,11,2,3,23,3,3,3,34,5,6,7,8,9,12])
t.pretty_print
t.insert(10)
t.pretty_print
#puts t.getmin().data
t.remove(11)
t.pretty_print
puts t.find(11)
proc = Proc.new {|v| puts v.data}
proc.to_proc
#p t.level_order(nil,true)
p t.preorder 
p t.inorder 
p t.postorder 

