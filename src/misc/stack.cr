class Stack(T)
    getter stack : Array(T)
    
    def initialize(@stack = Array(T).new())
        
    end

    delegate :push, :pop, :empty?, to: @stack

    # def push(e : T)
    #     @stack.push(e)
    # end
    
    # def pop
    #     @stack.pop
    # end

    def peek
        if stack.size > 0 
            return stack[-1] 
        else
            return nil
        end
    end

    def pretty_print(pp : PrettyPrint)
        pp.text @stack.join(",")
        pp
    end

end