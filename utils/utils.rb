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