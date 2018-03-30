#require_relative 'spec_helper.rb'
module Hotel

  class Room
    attr_reader :number
    def initialize(number)
      @number = number
      if @number < 1 || @number > 20
        raise ArgumentError.new("Invalid room number")
      end
    end
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
    end


  end
end
