require_relative 'spec_helper'

require 'date'

describe "Admin" do

  describe "initialize" do

    it "creates a Hotel instance" do
      hotel = Hotel::Admin.new
      hotel.must_respond_to :rooms
    end

    it "provides a list of all reservations" do
      hotel = Hotel::Admin.new
      hotel.reservations.must_be_instance_of Array
      hotel.reservations.length.must_equal 0
    end

    it "provides a list of all rooms" do
      hotel = Hotel::Admin.new
      hotel.new_rooms.must_be_instance_of Array
      hotel.new_rooms.length.must_equal 20

    end
  end


 describe "make_reservation" do

  it "returns an Array of Reservation objects" do
    hotel = Hotel::Admin.new
    hotel.make_reservation("2018-9-01", "2018-9-04", 2)
    hotel.make_reservation("2018-9-02", "2018-9-06", 4)
    hotel.make_reservation("2018-9-02", "2018-9-04", 5)

    hotel.reservations.each { |res| res.must_be_instance_of Hotel::Reservation }
    hotel.reservations[0].checkin.must_equal Date.new(2018, 9, 1)
  end
end

describe "get_reservation" do
  it "provides a list of all reservations on a given date" do
    hotel = Hotel::Admin.new
    hotel.make_reservation("2018-9-01", "2018-9-04", 2)
    hotel.make_reservation("2018-9-02", "2018-9-06", 4)


    hotel.get_reservation("2018-9-02").must_be_instance_of Array
    hotel.get_reservation("2018-9-02").length.must_equal 2

    hotel.get_reservation("2018-9-05").length.must_equal 1
  end
end
end
