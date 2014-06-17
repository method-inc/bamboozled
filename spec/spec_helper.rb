require_relative '../lib/bamboozled'

#dependencies
require 'minitest/autorun'
require 'webmock/minitest'

require 'turn'

Turn.config do |c|
 # :outline  - turn's original case/test outline mode [default]
 c.format  = :outline
 # turn on invoke/execute tracing, enable full backtrace
 c.trace   = true
 # use humanized test names (works only with :outline format)
 c.natural = true
end
