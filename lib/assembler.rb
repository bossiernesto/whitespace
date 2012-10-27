require_relative "stack"
require 'logger'
require_relative"/utils/utils"
require_relative "translate_table"

$logger=Logger.new("../WSLog.log",5,10*1024)

class Assembler
  include TranslateTable

  attr_accessor :source,:ops,:dest,:bytecode

  def initialize(bytecode=FALSE)
    @ops=Instruction.getAssembleTable() #TODO create bytecode table
    @bytecode=bytecode
    @encoders={:signed => :encode_signed,
               :unsigned= => :encode_unsigned}
  end

  #TODO: make assemble to be able to process inline instructions and flows
  public
  def assemble(file)
    self.setup_files(file)
    begin
      @source.each do |line|
        line=self.remove_comments(line)
        next if line.empty?
        if line =~ /^(\d+):$/
          translate("label #{$1}")
        else
          translate(line)
        end
      end
    rescue
      $logger.error(self.source_location("Error assembling file"))
    ensure
      @source.close unless @source.nil?
      @dest.close unless @dest.nil?
    end
  end

  def encode_signed(n)
    (n >= 0 ? " " : "\t") + encode_unsigned(n.abs)
  end

  def encode_unsigned(n)
    ("%b" % n).tr("01", " \t") + "\n"
  end

  protected
  def setup_files(file)
    filename=file
    if File.extname(file)=='.ws'
       $logger.info("File can't be of extension .ws renaming to .wsa")
       filename=rename_file_extension(file,"wsa")
       File.rename(file,filename)
    end
    @source=File.open(filename,'rb')
    @dest=File.open(rename_file_extension(file,'ws'),"w")
  end

  def source_location(message)
    "Source #{@source.path} at #{@source.lineno}: #{message}"
  end

  def remove_comments(string)
    string.strip.gsub(/#.*$/, "")
  end

  def translate(line)
    TRANSLATE_TABLE.each do |ws,opcode,arg|
      r=self.buildRegEx(opcode,arg)
      if line =~ Regexp.new(r)
        @dest.print ws
        if args
          begin
            encode=send @encoders[arg], $1.to_i
            @dest.print encode
            rescue NoMethodError
              raise(InvalidWhitespaceArgument)
          end
        end
      end
    end
    raise(InstructionNotFound)
  end

end


class InstructionNotFound < Exception

end

class InvalidWhitespaceArgument < Exception

end
