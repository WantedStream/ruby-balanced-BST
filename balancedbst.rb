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

    def initialize(arr)
        @root=build_tree(arr)
    end

    def build_tree(arr)
        arr=arr.uniq
        arr=arr.sort

        root=create_balancedBST_tree(arr,0,arr.length-1)

    end

    def level_order()
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
end