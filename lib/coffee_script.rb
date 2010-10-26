module CoffeeScript
  def self.locate_coffee_bin
    out = `which coffee`
    if $?.success?
      out.chomp
    else
      raise LoadError, "could not find `coffee` in PATH"
    end
  end

  def self.coffee_bin
    @@coffee_bin ||= locate_coffee_bin
  end

  def self.coffee_bin=(path)
    @@coffee_bin = path
  end

  # Compile a script (String or IO) to JavaScript.
  def self.compile(script, options = {})
    script = script.read if script.respond_to?(:read)
    command = "#{coffee_bin} -sp"
    command += " --bare" if options[:bare]

    IO.popen(command, "w+") do |f|
      f << script
      f.close_write
      f.read
    end
  end
  
  # Execute a script (String or IO) and return the stdout.
  # Note: the first argument will be process.argv[3], the second process.argv[4], etc.
  def self.execute(script, *args)
    script = script.read if script.respond_to?(:read)
    command = "#{coffee_bin} -s #{args.join(' ')}"    
    
    IO.popen(command, "w+") do |f|
      f << script
      f.close_write
      f.read
    end    
  end
end
