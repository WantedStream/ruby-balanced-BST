class Node
    include Comparable
    attr_accessor :data,:left,:right
    def initialize(data=nil,left=nil,right=nil)
        @data=data
        @left=left
        @right=right
    end

    def is_leaf()
        return @left==nil&&@right==nil
    end
    #def <=>(othernode)
     #   @data <=> othernode.data
    #end

    def has_only_left
        return @left!=nil&&@right==nil
    end

    def has_only_right
        return @left==nil&&@right!=nil
    end
end

class Tree
    attr_accessor :root
    def initialize(arr)
        @root=build_tree(arr)
    end

    def build_tree(t=self,arr)
        arr=arr.uniq
        arr=arr.sort

        t.root=create_balancedBST_tree(arr,0,arr.length-1)

    end

    
   
    def level_order_normal(block,arr)
        return if(@root==nil)
        return to_enum(:my_each) unless block!=nil

        queue=[]
      queue.push(@root) 
      while(queue.size>0)
        x=queue.shift
        arr.push(x.data)
        block.call x if(block!=nil)
        queue.push(x.left) if(x.left!=nil)
        queue.push(x.right) if(x.right!=nil) 
      end

     
    end

    def level_order(block,recursion=false)
        block.to_proc unless block.nil?
        arr=[] 
        if(@root==nil)
            return arr
        end
        if(recursion)
            level_order_recursion(block,[@root],arr)
        else
            level_order_normal(block,arr)
        end

        return arr unless block!=nil
    end

    
    def level_order_recursion(block,q,arr)
        
        if(q.size<=0)
            return
        end
        x = q.shift
        arr.push(x.data)
        if(x.left!=nil)
            q.push(x.left)
        end
        if(x.right!=nil)
            q.push(x.right)
        end
        
        block.call x if (block!=nil)
        level_order_recursion(block,q,arr)
            
           
    end

    

    def create_balancedBST_tree(arr,start,ending)
        return nil if(start>ending)
        
        mid=(start+ending)/2

        n = Node.new(arr[mid])
        n.left=create_balancedBST_tree(arr,start,mid-1)
        n.right=create_balancedBST_tree(arr,mid+1,ending)
        return n
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
      end

      def insert(value)
        insertToTree(@root,value)
      end

      def find(value)
        findRec(@root,value)
      end

      def findRec(t,value)
        return nil if(t.nil?)
        return t if(t.data==value)
        if(t.data>value)
        findRec(t.left,value) 
        else
        findRec(t.right,value) 
        end
      end

      def insertToTree(currentnode,value)
        
            if(currentnode.nil?)
                return 
            end

            if(currentnode.left==nil&&currentnode.right==nil)
                if(value<currentnode.data)
                    currentnode.left=Node.new(value)
                else
                    currentnode.right=Node.new(value)
                end
                return
            end

            if(value<currentnode.data)
                if(currentnode.left!=nil)
                insertToTree(currentnode.left,value)
                else
                    currentnode.left=Node.new(value)
                end
            else
                if(currentnode.right!=nil)
                    insertToTree(currentnode.right,value)
                    else
                        currentnode.right=Node.new(value)
          end       end
      end

      def remove(t=@root,value)
        if(value==@root.data)
            if(t.is_leaf)
                @root=nil
            else
         x=getmin(t.right).data
         remove(t,x)
         t.data=x
            end
        else
        removeRec(t,value)  
        end   
      end

      def removeRec(currentnode,value)
     
        if(currentnode.nil?)
            return 
        end
        if(currentnode.is_leaf)
            return
        end


        if(value<currentnode.data)
            if(!currentnode.left.nil?&&currentnode.left.data==value)
                removeLeft(currentnode,value)
            else
                removeRec(currentnode.left,value)
                return
            end
        else
            if(!currentnode.right.nil?&&currentnode.right.data==value)
                removeRight(currentnode,value)
            else
                removeRec(currentnode.right,value)
                return
            end
        end   

    
      end

      def removeLeft(currentnode,value)
        to_delete=currentnode.left
        if(to_delete.is_leaf)
            currentnode.left=nil
        elsif(to_delete.has_only_left)
            currentnode.left=to_delete.left
        elsif(to_delete.has_only_right)
            currentnode.left=to_delete.right
        else
            x=getmin(to_delete.right)
            if(x.data==to_delete.right.data)
                to_delete.right=to_delete.right.right
            else
            remove(to_delete.right,x.data)
            end
            to_delete.data=x.data
        end
      end
      def removeRight(currentnode,value)
        to_delete=currentnode.right
        if(to_delete.is_leaf)
            currentnode.right=nil
        elsif(to_delete.has_only_left)
            currentnode.right=to_delete.left
        elsif(to_delete.has_only_right)
            currentnode.right=to_delete.right
        else
            x=getmin(to_delete.right)
            if(x.data==to_delete.right.data)
                to_delete.right=to_delete.right.right
            else
            remove(to_delete.right,x.data)
            end
            to_delete.data=x.data
        end
      end

      def getmin(currentnode=@root)
        if(currentnode==nil)
            return nil
        elsif(currentnode.left==nil)
            return currentnode
        else
            getmin(currentnode.left)
        end
    end
    ###
    def inorder(block=nil,t=@root,arr=[])
        return arr if(t==nil)
           
        inorder(block,t.left,arr)
        if(block==nil)
            arr.push(t.data)
        else
        block.call(t)
        end
        inorder(block,t.right,arr)
    end
    def preorder(block=nil,t=@root,arr=[])
    return arr if(t==nil) 

    if(block==nil)
        arr.push(t.data)
    else
    block.call(t)
    end
        preorder(block,t.left,arr)
        preorder(block,t.right,arr)
    end

    def postorder(block=nil,t=@root,arr=[])
        return arr if(t==nil)
        postorder(block,t.left,arr)
        postorder(block,t.right,arr)
        if(block==nil)
            arr.push(t.data)
        else
        block.call(t)
        end
       return arr
    end

    def height(n=@root)
        return -1 if(n==nil)
        return [1+height(n.left),1+height(n.right)].max()   
    end
    def depth(n=@root,number)
        if(n==nil)
            return -1
        end
        dis=-1
        disleft=depth(n.left,number)
        disright=depth(n.right,number)
         if(n.data==number.data)
            return  dis+1
         elsif(disleft>=0)
            dis=disleft
            return dis+=1
         elsif(disright>=0)
            dis=disright
            return dis+=1

         end
        return dis
    end

    def balanced?(t=self)
       return (height(t.root.left)-height(t.root.right)).abs<=1
    end

    def rebalance(t=self)
        return t if(t.balanced?)
        arr=[]
        proc = Proc.new {|v| arr.push(v.data)}
        proc.to_proc
        level_order(proc,false)
        return Tree.new(arr)
    end
end