# spec_helper.rb
require 'simplecov'
SimpleCov.start

require 'minitest'
require 'minitest/spec'
require 'minitest/autorun'
require 'minitest/reporters'

require_relative '../lib/sale'
require_relative '../lib/product'
require_relative '../lib/vendor'
require_relative '../lib/market'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
