require 'coffee_script'
require 'test/unit'
require 'stringio'

class TestCoffeeScript < Test::Unit::TestCase
  def test_compile
    assert_equal "(function() {\n  puts('Hello, World!');\n}).call(this);\n",
      CoffeeScript.compile("puts 'Hello, World!'\n")
  end

  def test_compile_with_io
    io = StringIO.new("puts 'Hello, World!'\n")
    assert_equal "(function() {\n  puts('Hello, World!');\n}).call(this);\n",
      CoffeeScript.compile(io)
  end

  def test_compile_bare
    assert_equal "puts('Hello, World!');",
      CoffeeScript.compile("puts 'Hello, World!'\n", :bare => true)
  end
  
  def test_execute
    assert_equal "howdy\n", 
      CoffeeScript.execute("require('sys').puts('howdy')")
  end
  
  def test_execute_with_io
    io = StringIO.new("puts 'howdy'\n")
    assert_equal "howdy\n", 
      CoffeeScript.execute(io)
  end
  
  def test_execute_with_args
    assert_equal "first and second\n",
      CoffeeScript.execute('require("sys").puts(process.argv[3] + " and " + process.argv[4])', 'first', 'second')
  end
end
