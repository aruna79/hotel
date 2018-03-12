require_relative 'spec_helper'

describe "instantiation" do
  it "creates an instance" do
    hotel = Hotel::BlockReservation.new(Date.new(2018,5,5), Date.new(2018,5,9),150,"one",status=true)
    hotel.must_be_instance_of Hotel::BlockReservation
  end

  it "should have start_date" do
    hotel = Hotel::BlockReservation.new(Date.new(2018,5,5), Date.new(2018,5,9),150,"one",status=true)
    hotel.start_date.must_be_kind_of Date
    hotel.must_respond_to :block_id

  end

  it "should respond to status" do
    hotel = Hotel::BlockReservation.new(Date.new(2018,5,5), Date.new(2018,5,9),150,"one",status=true)
    hotel.status.must_equal true
  end
end
