require_relative 'spec_helper'

describe "instantiation" do
  before do
    @hotel = Hotel::Admin.new
  end

  it "creates an instance" do
    @hotel.must_be_instance_of Hotel::Admin
  end


  it "returns the list of all rooms" do
    @hotel.get_list.must_be_instance_of Array
  end
end

describe "make_reservation" do
  before do
    @hotel = Hotel::Admin.new
    start_date = Date.new(2018,05,03)
    end_date = Date.new(2018,05,06)
    @res = @hotel.make_reservation(start_date,end_date)
  end

  it "returns the list of all reservations" do
    @res.class.must_equal Array

  end

  it "raises an error if date range is invalid" do
    hotel = Hotel::Admin.new
    start_date = Date.new(2018,05,10)
    end_date =Date.new(2018,05,06)
    proc{hotel.make_reservation(start_date,end_date)}.must_raise ArgumentError
  end

end

describe "get_reservations on particular date" do

  it "raises error if given date is invalid" do
    hotel = Hotel::Admin.new
    proc{hotel.get_reservations(2)}.must_raise ArgumentError

  end

  it "returns the list of reservation available on a date" do
    hotel = Hotel::Admin.new
    hotel.make_reservation(Date.new(2018,05,5),Date.new(2018,05,7))
    hotel.make_reservation(Date.new(2018,05,5),Date.new(2018,05,8))
    hotel.make_reservation(Date.new(2018,05,7),Date.new(2018,05,9))

    re = hotel.get_reservations(Date.new(2018,05,5))
    re.length.must_equal 1
  end

  it "returns empty array if no reservation exists on that date" do
    hotel = Hotel::Admin.new
    hotel.make_reservation(Date.new(2018,05,5),Date.new(2018,05,7))
    hotel.make_reservation(Date.new(2018,05,6),Date.new(2018,05,8))
    hotel.make_reservation(Date.new(2018,05,7),Date.new(2018,05,9))

    reservations = hotel.get_reservations(Date.new(2018, 3, 11))
    reservations.length.must_equal 0
  end

end

describe "total cost" do

  it "it access the total cost per night" do
    hotel = Hotel::Admin.new
    start_date = Date.new(2018,05,03)
    end_date = Date.new(2018,05,06)
    hotel.make_reservation(start_date,end_date)

    hotel.must_respond_to :total_cost
    cost = hotel.total_cost(start_date,end_date)
    cost.must_be_kind_of Integer
    cost.must_equal 600

  end


  it "raises error for invalid dates" do
    hotel = Hotel::Admin.new
    start_date = Date.new(2018,05,9)
    end_date = Date.new(2018,05,06)
    #res = hotel.make_reservation(start_date,end_date,2)
    proc{hotel.total_cost(start_date,end_date)}.must_raise ArgumentError


  end
end

describe "list_of_available_rooms" do
  it "raises error if given date is invalid" do
    hotel = Hotel::Admin.new
    proc{hotel.get_reservations(2)}.must_raise ArgumentError

  end

  it "returns the list of empty rooms available on a date" do
    hotel = Hotel::Admin.new

    hotel.make_reservation(Date.new(2018,05,5),Date.new(2018,05,7))
    hotel.make_reservation(Date.new(2018,05,6),Date.new(2018,05,8))
    hotel.make_reservation(Date.new(2018,05,5),Date.new(2018,05,9))


    hotel.list_of_available_rooms(Date.new(2018,05,4)).length.must_equal 20
    hotel.list_of_available_rooms(Date.new(2018,05,5)).length.must_equal 19
    hotel.list_of_available_rooms(Date.new(2018,05,6)).length.must_equal 19
    hotel.list_of_available_rooms(Date.new(2018,05,8)).length.must_equal 20

  end

end

describe "reserve_list_available_rooms" do

  it "returns the list of all reservations" do
    hotel = Hotel::Admin.new
    start_date = Date.new(2018,05,03)
    end_date = Date.new(2018,05,06)
    reservation = hotel.reserve_available_rooms(start_date,end_date)
    reservation.class.must_equal Array

  end

  it "returns the newly created reservation" do
    hotel = Hotel::Admin.new
    start_date = Date.new(2018,05,03)
    end_date = Date.new(2018,05,06)
    before_length = hotel.all_reservations.length
    reservation = hotel.reserve_available_rooms(start_date,end_date)
    reservation.length.must_equal before_length + 1

  end

  it "raises an error there are no available rooms" do
    hotel = Hotel::Admin.new
    hotel.list_of_available_rooms(Date.new(2018,5,3))
    20.times do
      hotel.reserve_available_rooms(Date.new(2018,5,3),Date.new(2018,5,6))
    end

    proc{hotel.reserve_available_rooms(Date.new(2018,5,3),Date.new(2018,5,6))}.must_raise Exception
  end


  it "raises an error for invalid date range" do
    hotel = Hotel::Admin.new
    start_date = Date.new(2018,5,10)
    end_date =Date.new(2018,5,6)
    proc{hotel.reserve_available_rooms(start_date,end_date)}.must_raise ArgumentError

  end

end

describe "create_block" do
  it "creates an instance of BlockReservation class" do
    hotel = Hotel::Admin.new
    block = hotel.create_block(Date.new(2018,5,5), Date.new(2018,5,9),"one",150)
    block.must_be_instance_of Array
  end

  it " creates a block of rooms " do
    hotel = Hotel::Admin.new
    block = hotel.create_block(Date.new(2018,5,5), Date.new(2018,5,9),"one",150)

    block[0].block_id.must_equal "one"
    block[0].status.must_equal true
    block[0].room_number.must_be_instance_of Hotel::Room
    block[0].discount_rate.must_equal 150

  end


  it "rasies an ArgumentError if check in date and/or check out date is invalid" do
    hotel = Hotel::Admin.new
    proc { hotel.create_block("2018-3-5", "2018-3-7", "one", 150) }.must_raise ArgumentError
  end
end

describe "reserve_block_room" do
  it "reserves a block of room" do
    hotel = Hotel::Admin.new
    block = hotel.create_block(Date.new(2018,5,5), Date.new(2018,5,9),"one",150)
    block = hotel.reserve_block_room("one")
    block[0].room_number.number.must_equal 2
    block[0].status.must_equal true
  end

  it "adds the new reserved block to the list of all reservations" do
    hotel = Hotel::Admin.new
    hotel.create_block(Date.new(2018,5,5), Date.new(2018,5,9),"one",150)
    hotel.reserve_block_room("one")

    before_length = hotel.all_reservations.length
    reservation = hotel.reserve_block_room("one")
    reservation.length.must_equal before_length + 4

  end
  it "returns reservation with correct information" do
    hotel = Hotel::Admin.new
    hotel.create_block(Date.new(2018,5,5), Date.new(2018,5,9),"one",150)
    block = hotel.reserve_block_room("one")

    block[0].start_date.must_equal Date.new(2018,5,5)
    block[0].end_date.must_equal Date.new(2018,5,9)
    (1..20).to_a.include?(block[0].room_number.number).must_equal true

  end



end

describe "check_block_availability" do
  it "raises error if there are no rooms available in block" do
    hotel = Hotel::Admin.new
    hotel.create_block(Date.new(2018,5,5), Date.new(2018,5,9),"one",150)

    5.times do
      hotel.reserve_block_room("one")
    end
    proc{hotel.check_block_availability("one")}.must_raise Exception


  end
end
