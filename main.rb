require_relative "balancedbst"

tree=Tree.new(Array.new(15) { rand(1..100) })
p tree.balanced?
proc = Proc.new {|v| print v.data.to_s+","}
tree.level_order(proc,false)
puts

tree.preorder(proc)
puts 
tree.inorder(proc)
puts
tree.postorder(proc)
puts
tree.insert(400)
tree.insert(1000)
tree.insert(1500)
tree.insert(2000)
tree.insert(3000)
tree.insert(20030)
puts tree.balanced? 
tree=tree.rebalance
puts tree.balanced? 
tree.level_order(proc,false)
puts
tree.preorder(proc)
puts 
tree.inorder(proc)
puts
tree.postorder(proc)
puts