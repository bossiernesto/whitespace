module TranslateTable

  SPACE="\s"
  TAB="\t"
  LF_TOKEN="\n"

  #Instruction Modification Pattern
  IMP=[[SPACE, :Stack],  #Stack manipulation
       [TAB+SPACE,:Arithmetic], #Arithmetic
       [TAB*2,:Heap], # Heap Manipulation
       [LF_TOKEN,:Flow], #Flow Control
       [TAB+LF_TOKEN,:WSIO]  #Whitespace IO
  ]

  TRANSLATE_TABLE=[
      ["  ", :push, :signed],
      [" \n ", :dup],
      [" \n\t", :swap],
      [" \n\n", :discard],
      ["\t   ", :add],
      ["\t  \t", :sub],
      ["\t  \n", :mul],
      ["\t \t ", :div],
      ["\t \t\t", :mod],
      ["\t\t ", :store],
      ["\t\t\t", :retrieve],
      ["\n  ", :label, :unsigned],
      ["\n \t", :call, :unsigned],
      ["\n \n", :jump, :unsigned],
      ["\n\t ", :jz, :unsigned],
      ["\n\t\t", :jn, :unsigned],
      ["\n\t\n", :ret],
      ["\n\n\n", :exit],
      ["\t\n  ", :outchar],
      ["\t\n \t", :outnum],
      ["\t\n\t ", :readchar],
      ["\t\n\t\t", :readnum],
  ]

  def getImpType(instr)
    fail(NotImplementedError) #TODO: implement
  end

  def buildRegEx(opcode,arg)
    r = "^#{opcode}"
    if arg
      r << '\s+('
      r << '(-|\+)?' if arg == :signed
      r << '\d+)'
    end
    r << '$'
    return r
  end

end