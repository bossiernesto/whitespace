def rename_file_extension(source, extension)
  dirname  = File.dirname(source)
  basename = File.basename(source, ".*")
  extname  = File.extname(source)
  if extname == ""
    if basename[0,1]=="."
      target = dirname + "/." + extension
    else
      target = source + "." + extension
    end
  else
    target = dirname + "/" + basename + "." + extension
  end
  File.rename(source, target)
  target
end

def outputError(message,fatal=TRUE)
  $logger.error(message)#Log error
  if fatal
    exit 1
  end
end

module Reflect

  class ClassFactory

    def self.create_class(name,attributes,methods)
       object=Object.new do |obj|
         puts(obj)
         #set attributes
        attributes.each {|attr| self.create_attr(obj,attr)}
         #set methods
         methods.each {|f,block| self.create_method(obj,f,&block)}
       end

       Kernel.const_set name, object
    end

    def create_method(obj,name, &block )
      obj.class.send( :define_method, name, &block )
    end

    def create_attr(obj, name )
      create_method(obj, "#{name}=".to_sym ) { |val|
        instance_variable_set( "@" + name, val)
      }

      create_method(obj, name.to_sym ) {
        instance_variable_get( "@" + name )
      }


    end

  end

end


module VarInitialize

def initialize(args)
  args.keys.each { |name| instance_variable_set "@" + name.to_s, args[name] }
end

def create_method( name, &block )
  self.class.send( :define_method, name, &block )
end

def create_attr( name )
  create_method( "#{name}=".to_sym ) { |val|
    instance_variable_set( "@" + name, val)
  }

  create_method( name.to_sym ) {
    instance_variable_get( "@" + name )
  }
end

end

module WS_debug_print
  def debug_print
    str=self.class.name+"{"
    instance_variables.each do |var|
      str+= var.to_s.gsub("@","")+"'=" + self.instance_variable_get(var)
      str+=(var!=instance_variables.last) ? ", " :'}'
    end
    puts(str)
  end
end

