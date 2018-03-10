require_relative 'spec_helper'

describe "instantiation" do
  it "creates an instance" do
    hotel = Hotel::Room.new(1)
    hotel.must_be_instance_of Hotel::Room
  end

  it "should have room number" do
    hotel = Hotel::Room.new(10)
    hotel.number.must_be_kind_of Integer
    hotel.must_respond_to :number
    hotel.number.must_equal 10

  end

  it "should raise an error when room number is invalid" do
    proc{Hotel::Room.new(23)}.must_raise ArgumentError

  end
end
