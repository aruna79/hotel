require_relative 'spec_helper'

describe "instantiation" do
  before do
    @hotel = Hotel::Admin.new
  end

  it "creates an instance" do
    @hotel.must_be_instance_of Hotel::Admin
  end

  describe "get_list" do

    it "returns the list of all rooms" do
      @hotel.get_list.must_be_instance_of Array
    end
  end

  describe "make_reservation" do
    before do
      @hotel = Hotel::Admin.new
      start_date = Date.new(2018,05,03)
      end_date = Date.new(2018,05,06)
      @res = @hotel.make_reservation(start_date,end_date,2)
    end

    it "returns the list of all reservations" do
      @res.class.must_equal Array
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
      proc{hotel.get_reservations(2)}.must_raise ArgumentError

    end

    it "returns the list of reservation available on a date" do
      hotel = Hotel::Admin.new
      hotel.make_reservation(Date.new(2018,05,5),Date.new(2018,05,7),1)
      hotel.make_reservation(Date.new(2018,05,5),Date.new(2018,05,8),2)
      hotel.make_reservation(Date.new(2018,05,7),Date.new(2018,05,9),3)

      re = hotel.get_reservations(Date.new(2018,05,5))
      re.length.must_equal 1
    end

    it "returns empty array if no reservation exists on that date" do
      hotel = Hotel::Admin.new
      hotel.make_reservation(Date.new(2018,05,5),Date.new(2018,05,7),3)
      hotel.make_reservation(Date.new(2018,05,6),Date.new(2018,05,8),3)
      hotel.make_reservation(Date.new(2018,05,7),Date.new(2018,05,9),3)

      reservations = hotel.get_reservations(Date.new(2018, 3, 11))
      reservations.length.must_equal 0
    end

  end

  describe "total cost" do

    it "it access the total cost per night" do
      hotel = Hotel::Admin.new
      start_date = Date.new(2018,05,03)
      end_date = Date.new(2018,05,06)
      hotel.make_reservation(start_date,end_date,2)
      
      hotel.must_respond_to :total_cost
      cost = hotel.total_cost(start_date,end_date)
      cost.must_be_kind_of Integer
      cost.must_equal 600
    end
  end
end
