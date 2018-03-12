require 'simplecov'
SimpleCov.start

# specs/spec_helper.rb
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
require 'minitest/skip_dsl'
require 'pry'

# Require any classes
# ex require_relative 'lib/foo.rb'
#require_relative '../lib/admin.rb'
#require_relative '../lib/room.rb'
#require_relative '../lib/reservation.rb'
#require_relative '../lib/admin_wave1.rb'
require_relative '../lib/room_wave1.rb'
require_relative '../lib/reservation_wave1.rb'
require_relative '../lib/admin_block.rb'
require_relative '../lib/block.rb'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new
