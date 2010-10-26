Gem::Specification.new do |s|
  s.name      = 'ruby-coffee-script'
  s.version   = '1.1.0'
  s.date      = '2010-10-26'

  s.homepage    = "http://github.com/josh/ruby-coffee-script"
  s.summary     = "Ruby CoffeeScript wrapper"
  s.description = <<-EOS
    Ruby CoffeeScript is a thin wrapper around the coffee binary.
  EOS

  s.files = [
    'lib/coffee-script.rb',
    'lib/coffee_script.rb',
    'LICENSE',
    'README.md'
  ]

  s.requirements << 'node'
  s.requirements << 'coffee-script'

  s.authors           = ['Jeremy Ashkenas', 'Joshua Peek', 'Ryan Koopmans']
  s.email             = 'josh@joshpeek.com'
  s.rubyforge_project = 'coffee-script'
end
