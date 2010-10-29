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
    command = "#{coffee_bin} -sp"
    command += " --bare" if options[:bare]
    command += " --no-wrap" if options[:no_wrap]
    run_script_with_command(script, command)
  end
  
  # Evaluate a script (String or IO) and return the stdout.
  # Note: the first argument will be process.argv[3], the second process.argv[4], etc.
  def self.evaluate(script, *args)
    run_script_with_command(script, "#{coffee_bin} -s #{args.join(' ')}")
  end

  private

  def self.run_script_with_command(script, command)
    script = script.read if script.respond_to?(:read)
    IO.popen(command, "w+") do |f|
      f << script
      f.close_write
      f.read
    end
  end
end
