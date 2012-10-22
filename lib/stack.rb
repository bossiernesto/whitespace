#TODO: add documentation using rDoc
class WsStack < Array

  attr_accessor :stack

  def initialize
    @stack=[]
  end

  def push(value)
    @stack.push value
    return self #This can be used later as stack.push(4).push(5)
  end

  def pop
    @stack.pop
  end

  def popRelative(pos)
    newpos=(pos.abs)
    if newpos>=self.count
      return @stack.pop(self.count)
    end
    temp=@stack.pop(newpos)
    extracted=temp.first
    @stack+=temp[1..-1]
    return extracted
  end

  def clear
    @stack.clear unless @stack.nil?
  end

  def count
    @stack.count
  end

  def look(pos) #retrieve value from top of stack stack relative position
    newpos=-(pos.abs)
     if newpos>=self.count
       return @stack.first
     end
     return @stack[newpos]
  end

  def dupTop()
    #Duplicate the top item on the stack
    value=@stack.pop
    2.times {@stack.push(value)}
  end

  def swapTop()
    #Swap the two top items in the Stack
    newItems=[]
    2.times {newItems.push(@stack.pop)}
    @stack+=newItems
  end

  def copy(pos)
     #copy the nth item on the stack onto the top of the stack
     value=self.look(pos)
     @stack.push(value)
  end
end