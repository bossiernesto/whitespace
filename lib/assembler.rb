require_relative "stack"
require 'logger'
require_relative"/utils/utils"
require_relative "translate_table"

$logger=Logger.new("../WSLog.log",5,10*1024)

class Assembler
  include TranslateTable

  attr_accessor :source,:ops,:dest

  def initialize
    @ops=Instruction.getAssembleTable()
  end

  #TODO: make assemble to be able to process inline instructions and flows
  public
  def assemble(file)
    self.setUpFiles(file)
    begin
      for line in @source
        line=self.removeComments(line)
        next if line.empty?
        if line =~ /^(\d+):$/
          translate("label #{$1}")
        else
          translate(line)
        end
      end
    rescue
      $logger.error(self.informSourceLocation("Error assembling file"))
    ensure
      @source.close unless @source.nil?
      @dest.close unless @dest.nil?
    end
  end

  def encodeSignedNumber(n)
    (n >= 0 ? " " : "\t") + encodeUnsignedNumber(n.abs)
  end

  def encodeUnsignedNumber(n)
    ("%b" % n).tr("01", " \t") + "\n"
  end

  protected
  def setUpFiles(file)
    filename=file
    if File.extname(file)=='.ws'
       $logger.info("File can't be of extension .ws renaming to .wsa")
       filename=rename_file_extension(file,"wsa")
       File.rename(file,filename)
    end
    @source=File.open(filename,'rb')
    @dest=File.open(rename_file_extension(file,'ws'),"w")
  end

  def informSourceLocation(message)
    "Source #{@source.path} at #{@source.lineno}: #{message}"
  end

  def removeComments(string)
    string.strip.gsub(/#.*$/, "")
  end

  def translate(line)
    TRANSLATE_TABLE.each do |ws,opcode,arg|
      r=self.buildRegEx(opcode,arg)
      if line =~ Regexp.new(r)
        @dest.print ws
        case arg
          when :signed
            @dest.print encodeSignedNumber($1.to_i)
          when :unsigned
            @dest.print encodeUnsignedNumber($1.to_i)
        end
      end
    end
    raise(InstructionNotFound)
  end

end


class InstructionNotFound < Exception

end
