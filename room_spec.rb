require_relative 'spec_helper'

describe "Room" do
    
  describe "initialize" do
    it "each room has a number that can be read" do
      Hotel::Room.new(1)
      Hotel::Room.new(20)
      Hotel::Room.new(2)
      room1.number.must_equal 1
      room2.number.must_equal 20
    end

    it "new rooms have a default status :available" do
      room3.status.must_equal :available
    end
  end
end
