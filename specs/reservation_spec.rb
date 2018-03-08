require_relative 'spec_helper'

require 'date'

describe "Reservation" do

  describe "initialize" do
    it "has a date range" do
      admin = Hotel::Reservation.new("2018-9-01", "2018-9-04", 2)
      admin.must_respond_to :checkin
      admin.must_respond_to :checkout
      admin.checkin.must_be_instance_of Date
      admin.checkin.must_equal Date.new(2018, 9, 1)
      admin.checkout.must_equal Date.new(2018, 9, 4)
    end

    it "has a room" do
      admin = Hotel::Reservation.new("2018-9-01", "2018-9-04", 2)
      admin.room.must_equal 2
    end

    it "has a total_cost" do
      admin = Hotel::Reservation.new("2018-9-01", "2018-9-04", 2)
      admin.must_respond_to :total_cost
      admin.total_cost.must_equal 600
    end

    it "raises an error when given an incorrect date range" do
      proc { Hotel::Reservation.new("2018-9-02", "2018-08-30", 3) }.must_raise ArgumentError

      proc { Hotel::Reservation.new("2018-13-30", "2018-03-03", 3) }.must_raise ArgumentError

      proc { Hotel::Reservation.new("2018-02-25", "2018-02-29")}.must_raise ArgumentError
    end
  end
end
