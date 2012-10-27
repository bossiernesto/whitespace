require '../utils/utils'

class StackFrame
  include WS_debug_print

  attr_accessor :sym,:retAddress,:locals

  def initialize(sym,retaddr,locals)
    @sym=sym
    @ret_address=retaddr
    @locals=locals
  end

end

class FunctionSymbol
  include VarInitialize,WS_debug_print

  attr_accessor :name,:args,:locals,:address

  def initialize(name,args,locals,addr)
    @name=name
    @args=args
    @locals=locals
    @address=addr
  end

end
