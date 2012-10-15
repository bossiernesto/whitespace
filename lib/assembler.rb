require_relative "stack"
require 'logger'
require_relative"/utils/utils"
require_relative "Instruction"

$logger=Logger.new("../WSLog.log",5,10*1024)

class Assembler

  attr_accessor :stack,:source,:ops,:dest

  def initialize
    @ops=Instruction.getAssembleTable()
  end

  public
  def assemble(file)
    self.setUpFiles(file)
    begin
      for line in @source
        line=self.removeComments(line)
        self.translate(line)
      end
    rescue
      $logger.error(self.informSourceLocation("Error assembling file"))
    ensure
      @source.close unless @source.nil?
      @dest.close unless @dest.nil?
    end
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

  def encodeSignedNumber(n)
    (n >= 0 ? " " : "\t") + encodeUnsignedNumber(n.abs)
  end

  def encodeUnsignedNumber(n)
    ("%b" % n).tr("01", " \t") + "\n"
  end

  def translate(line)
    fail(NotImplementedError)
  end

end