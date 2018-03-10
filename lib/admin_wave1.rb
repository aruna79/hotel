
require_relative 'room_wave1'
require_relative 'reservation_wave1'
require 'date'


module Hotel
  NUMBER_OF_ROOMS = 20

  class Admin
    attr_reader :room,:all_reservations
    @@list_of_rooms = []
    def initialize

      NUMBER_OF_ROOMS.times do |i|
        room = Hotel::Room.new(i+1)
        @@list_of_rooms << room
        @all_reservations = []
      end

    end

    # As an administrator, I can access the list of all of the rooms in the hotel
    def get_list
      rooms = []
      @@list_of_rooms.each do |room|
        rooms << room.number
      end
      return rooms

    end

    # - As an administrator, I can reserve a room for a given date range

    def make_reservation(start_date,end_date,room_no)

      reservation = Hotel::Reservation.new(start_date,end_date,room_no)
      @all_reservations << reservation

      return @all_reservations

    end

# - As an administrator, I can access the list of reservations for a specific date

    def get_reservations(date)

      if date.class!= Date
        raise ArgumentError.new("invalid date")
      end

      @all_reservations.each do |reservation|
        list =[]
        if reservation.start_date <= date || reservation.end_date > end_date
          list << reservation
        end
        return list
      end

    end

# - As an administrator, I can get the total cost for a given reservation
    def total_cost(start_date,end_date)
      datediff = end_date - start_date
      cost= datediff * 200
      return cost.to_i
    end

  end
end

# h= Hotel::Admin.new
# start_date = Date.new(2018,5,3)
# end_date =Date.new(2018,5,9)
# puts h.make_reservation(start_date,end_date,3)
# #puts h.total_cost(start_date,end_date)
# puts h.list_reservations(Date.new(2018,5,4))
