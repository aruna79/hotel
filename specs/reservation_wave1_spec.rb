require_relative 'spec_helper'

describe "initialize" do
  before do
    @start_date = Date.new(2018,05,5)
    @end_date = Date.new(2018,05,7)
    @room_number = Hotel::Room.new(3)
    @reservation = Hotel::Reservation.new(@start_date,@end_date,@room_number)
  end
  it "creates an instance" do

    @reservation.must_be_instance_of Hotel::Reservation
  end

  it "access the start_date" do
    @reservation.must_respond_to :start_date
    @reservation.start_date.must_be_kind_of Date
    @reservation.start_date.must_equal Date.new(2018,05,5)
  end

  it "access the end_date" do
    @reservation.must_respond_to :end_date
    @reservation.end_date.must_be_kind_of Date
    @reservation.end_date.must_equal Date.new(2018,05,7)

  end
  it "access the room_no" do
    @reservation.must_respond_to :room_number
    @reservation.room_number.must_be_instance_of Hotel::Room
    @room_number.number.must_equal 3

  end

  it "raises error when end date is before  start date" do
    proc{Hotel::Reservation.new(Date.new(2018,05,7),Date.new(2018,05,5),3)}.must_raise ArgumentError
  end

  it"raises error if start_date is less than today's date" do
    proc{Hotel::Reservation.new(Date.new(2018,03,7),Date.today,3)}.must_raise ArgumentError
  end


end
