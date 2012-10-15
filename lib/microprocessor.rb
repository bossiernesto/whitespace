require_relative "stack"
require 'logger'
require_relative"../utils/utils"

$logger=Logger.new("../WSLog.log",5,10*1024)

class Microprocessor

  def initialize
    @stack=WsStack.new()
    @source=nil
    @ops=[]
    @dest=nil
  end

  public
  def assemble(file)
    self.setUpFiles(file)
    begin
      for line in @source
        self.removeComments(line)

      end
    rescue
      $logger.error(self.informSourceLocation("Error assembling file"))
    ensure
      @source.close unless @source.nil?
      @dest.close unless @dest.nil?
    end

  end

  protected
  def execute
    fail(NotImplementedError)
  end

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
    fail(NotImplementedError)
  end

end