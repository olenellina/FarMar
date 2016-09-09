# Spec Helper

require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'

require './lib/sale'
require './lib/product'
require './lib/vendor'
require './lib/market'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
