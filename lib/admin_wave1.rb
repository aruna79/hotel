
require_relative 'room_wave1'
require_relative 'reservation_wave1'
require 'date'

module Hotel
  NUMBER_OF_ROOMS = 20

  class Admin
    attr_reader :list_of_rooms,:all_reservations

    def initialize

        @all_reservations = []
        @list_of_rooms = create_rooms
    end

     def create_rooms
       @list_of_rooms = []
       NUMBER_OF_ROOMS.times do |i|
         room = Hotel::Room.new(i+1)
         @list_of_rooms << room
       end
       return @list_of_rooms
     end

    # As an administrator, I can access the list of all of the rooms in the hotel
    def get_list
      rooms = []
      @list_of_rooms.each do |room|
        rooms << room.number
      end
      return rooms

    end

    # - As an administrator, I can reserve a room for a given date range
    def make_reservation(start_date,end_date)
      room_number = @list_of_rooms.sample
      reservation = Hotel::Reservation.new(start_date,end_date,room_number)
      @all_reservations << reservation
      return @all_reservations
    end

    # - As an administrator, I can access the list of reservations for a specific date
    def get_reservations(date)

      if date.class!= Date
        raise ArgumentError.new("invalid date")
      end

      @all_reservations.each do |res|
        list =[]
        if res.start_date <= date && res.end_date > date
          list << res
        end
        return list
      end

    end

    # As an administrator, I can view a list of rooms that are not reserved for a given date range
    def list_of_available_rooms(date)
      if date.class!= Date
        raise ArgumentError.new("invalid date")
      end

      reserved_list = get_reservations(date)
      reserved_rooms = []
      reserved_list.each do |reservation|
        reserved_rooms << reservation.room_number
      end
      return @list_of_rooms - reserved_rooms
      #return @available_rooms
    end

    # To reserve available rooms for a given date range
    def reserve_available_rooms(start_date,end_date)

      rooms_reserved_date = []
      rooms_available_range = []
      # to store list of all rooms
      rooms_available_range = @list_of_rooms
      # to find the rooms that are reserved for a given date in the range
      (start_date...end_date).each do |date|
      # to check which room is reserved for "date"
        @all_reservations.each do |res|
          list =[]
          if res.start_date <= date && res.end_date > date
            # Storing the reserved rooms in the "list" array
            list << res.room_number
          end
          # remove the reserved rooms from all rooms
          rooms_available_range = rooms_available_range - list
        end
      end

      if rooms_available_range.empty?
        raise Exception.new("No rooms are available")
      else
        availability = rooms_available_range[0]

        reservation = Hotel::Reservation.new(start_date,end_date,availability)
        @all_reservations << reservation
        return @all_reservations
      end

    end

    # - As an administrator, I can get the total cost for a given reservation
    def total_cost(start_date,end_date)
      if start_date < end_date
        datediff = end_date - start_date
        cost= datediff * 200
        return cost.to_i
      else
        raise ArgumentError.new("Check-in date must be before check-out date")
      end

    end

  end
end



# h= Hotel::Admin.new
#   start_date = Date.new(2018,5,3)
#   end_date =Date.new(2018,5,6)
#  #print "reservation of room\n"
#  h.make_reservation(start_date,end_date)
# # #puts h.total_cost(start_date,end_date)
# # puts h.list_reservations(Date.new(2018,5,4))
# #print"\n**************************************\n"
# #res_room = []
# #print "available room\n"
# #h.list_of_available_rooms(Date.new(2018,5,6))
# print"\n**************************************\n"
# print "reserve available room for dates 5th to 7th\n"
# 20.times do
# h.reserve_available_rooms(Date.new(2018,5,5), Date.new(2018,5,7))
# print"\n**************************************\n"
# print "reserve available room for dates 5th to 7th\n"
#
# h.reserve_available_rooms(Date.new(2018,5,6), Date.new(2018,5,9))
# print"\n**************************************\n"
# #print "\n*********\n"
# end
# #print"\n**************************************\n"
# #print "available room\n"
# #print h.list_of_available_rooms(Date.new(2018,5,6))
# #print res_room
