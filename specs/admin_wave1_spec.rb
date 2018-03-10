require_relative 'spec_helper'

describe "instantiation" do
  it "creates an instance" do
    hotel = Hotel::Admin.new
    hotel.must_be_instance_of Hotel::Admin

  end

  describe "get_list" do
    it "returns the list of all rooms" do
      hotel = Hotel::Admin.new
      hotel.get_list.must_be_instance_of Array

    end
  end

  describe "make_reservation" do
    it "returns the list of all reservations" do
      hotel = Hotel::Admin.new
      start_date = Date.new(2018,05,03)
      end_date =Date.new(2018,05,06)
      hotel.make_reservation(start_date,end_date,2)
    end

    it "raises an error if date range is invalid" do
      hotel = Hotel::Admin.new
      start_date = Date.new(2018,05,10)
      end_date =Date.new(2018,05,06)
      proc{hotel.make_reservation(start_date,end_date,2)}.must_raise ArgumentError
    end

    it "raises an error if room_number is invalid " do
      hotel = Hotel::Admin.new
      start_date = Date.new(2018,05,03)
      end_date =Date.new(2018,05,06)
      proc{hotel.make_reservation(start_date,end_date,25)}.must_raise ArgumentError
    end
  end

  describe "get_reservations on particular date" do
    it "raises error if given date is invalid" do
      hotel = Hotel::Admin.new
      start_date = Date.new(2018,05,03)
      end_date =Date.new(2018,05,06)
      proc{hotel.get_reservations(2)}.must_raise ArgumentError

    end

  end

end
