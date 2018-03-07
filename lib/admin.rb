require 'date'

module Hotel
  STANDARD_RATE = 200
  NUMBER_OF_ROOMS =20

  class Admin

  attr_reader :rooms, :reservations

  def initialize
    @rooms = new_rooms,
    @reservations = []
  end

  def make_reservation(checkin_date,checkout_date,room_number)
    reservation = Reservation.new(checkin_date,checkout_date,room_number)
    reservations << reservation
  end

  def get_reservation(date)
    check_date = Date.parse(date)

    reservations.select{|res|check_date >= res.checkin && check_date < res.checkout}

  end

  def new_rooms
    rooms = []
    i = 0
    NUMBER_OF_ROOMS.times do
      rooms << Room.new(i+1)
      i =+ 1
    end
    rooms
  end
end
end
