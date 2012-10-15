class WsStack < Array

  def initialize
    @stack=[]
  end

  def push(value)
    @stack.push value
    return self #This can be used later as stack.push(4).push(5)
  end

  def pop
    @stack.pop
    return self
  end

  def pop_relative(pos)
    newpos=-(pos.abs)
    if newpos>self.count
      return @stack.pop(self.count)
    end
    temp=@stack.pop(newpos)
    extracted=temp.first
    @stack+=temp[1:-1]
    return extracted
  end

  def clear
    @stack.clear unless @stack.nil?
  end

  def count
    @stack.length
  end

  def look(pos) #retrieve value from top of stack stack relative position
    newpos=-(pos.abs)
    if newpos>self.count
      return @stack.first
    end
    return @stack[newpos]

  end



end